import crypto from "node:crypto";
import { NextResponse } from "next/server";
import { readBoundedText } from "@/lib/api-security";
import { getClientIp, sharedRateLimit } from "@/lib/rate-limit";
import {
  markWebhookEventProcessed,
  rememberWebhookEvent,
  verifyAndActivatePayment,
} from "@/services/payments/payment-service";
import { verifyFlutterwaveWebhookSignature } from "@/services/payments/flutterwave";

export const runtime = "nodejs";
export const maxDuration = 60;

type FlutterwaveWebhookPayload = {
  id?: string | number;
  event?: string;
  type?: string;
  event_id?: string;
  data?: {
    id?: number;
    tx_ref?: string;
    status?: string;
  };
};

const MAX_WEBHOOK_BYTES = 256 * 1024;

function getEventKey(rawBody: string, payload: FlutterwaveWebhookPayload) {
  const eventType = payload.type ?? payload.event ?? "unknown";
  return (
    (payload.event_id ? `${eventType}:${payload.event_id}` : undefined) ??
    (payload.id ? `${eventType}:${payload.id}` : undefined) ??
    `${eventType}:${crypto.createHash("sha256").update(rawBody).digest("hex")}`
  );
}

export async function POST(request: Request) {
  const rawBody = await readBoundedText(request, MAX_WEBHOOK_BYTES);
  if (rawBody === null) {
    return NextResponse.json({ error: "Payload too large." }, { status: 413 });
  }

  if (!verifyFlutterwaveWebhookSignature(rawBody, request.headers)) {
    console.warn("payments_webhook_invalid_signature");
    return NextResponse.json({ error: "Invalid signature." }, { status: 401 });
  }

  // Unauthenticated callers must not be able to spend the provider's rate
  // limit budget and block legitimate callbacks from a shared provider IP.
  const ip = getClientIp(request);
  const ipLimit = await sharedRateLimit({
    key: `payments:webhook:ip:${ip}`,
    limit: 120,
    windowMs: 10 * 60 * 1000,
  });
  if (!ipLimit.allowed) {
    return NextResponse.json(
      { error: "Too many webhook attempts." },
      {
        status: 429,
        headers: { "Retry-After": String(ipLimit.retryAfterSeconds) },
      },
    );
  }

  let payload: FlutterwaveWebhookPayload;
  try {
    payload = JSON.parse(rawBody) as FlutterwaveWebhookPayload;
  } catch {
    return NextResponse.json({ error: "Invalid JSON." }, { status: 400 });
  }

  const eventKey = getEventKey(rawBody, payload);
  const eventType = payload.type ?? payload.event;
  const transactionId = payload.data?.id;
  const txRef = payload.data?.tx_ref;

  try {
    const needsProcessing = await rememberWebhookEvent(
      eventKey,
      payload,
      txRef,
      transactionId,
    );
    if (!needsProcessing)
      return NextResponse.json({ received: true, duplicate: true });

    if (eventType !== "charge.completed") {
      // A chargeback's data.id is a dispute ID, not a payment transaction ID.
      // Record it for manual review; never treat it as proof of payment.
      console.warn("payments_webhook_non_charge_event", {
        eventKey,
        eventType,
      });
      await markWebhookEventProcessed(eventKey);
      return NextResponse.json({ received: true, ignored: true });
    }

    if (!transactionId || !Number.isSafeInteger(Number(transactionId))) {
      console.warn("payments_webhook_missing_transaction_id", {
        eventKey,
        txRef,
      });
      return NextResponse.json({ received: false }, { status: 503 });
    }

    const result = await verifyAndActivatePayment(String(transactionId));
    if (result.state === "pending") {
      // Only acknowledge an event after durable processing or a verified
      // terminal failure. Flutterwave can retry this signed event later.
      return NextResponse.json({ received: false }, { status: 503 });
    }
    await markWebhookEventProcessed(eventKey);
    return NextResponse.json({ received: true, verified: result.success });
  } catch (error) {
    console.error("payments_webhook_processing_failed", error);
    return NextResponse.json({ received: false }, { status: 503 });
  }
}
