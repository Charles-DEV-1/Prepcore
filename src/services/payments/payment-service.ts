import crypto from "node:crypto";
import { siteConfig } from "@/config/site";
import {
  getPaymentPlan,
  getPaymentRedirectUrl,
  type PaymentPlanKey,
} from "@/config/payments";
import { createServiceRoleClient } from "@/services/supabase/admin";
import {
  createFlutterwaveCheckout,
  createTxRef,
  isTrustedFlutterwaveCheckoutUrl,
  verifyFlutterwaveTransaction,
  verifyFlutterwaveTransactionByReference,
  type FlutterwaveVerificationResponse,
} from "@/services/payments/flutterwave";

type CreatePaymentInput = {
  userId: string;
  email: string;
  name?: string;
  phone?: string;
  planKey?: PaymentPlanKey;
};

export type VerificationResult = {
  success: boolean;
  state: "success" | "pending" | "failed";
  txRef?: string;
  alreadyProcessed?: boolean;
  error?: string;
};

function createIdempotencyKey(userId: string, txRef: string) {
  return crypto.createHash("sha256").update(`${userId}:${txRef}`).digest("hex");
}

function isVerifiedSuccessfulPayment(
  verification: FlutterwaveVerificationResponse,
  expected: { txRef: string; amount: number; currency: string },
) {
  const data = verification.data;
  if (verification.status !== "success" || !data) return false;
  return (
    data.status === "successful" &&
    data.tx_ref === expected.txRef &&
    Number(data.amount) === expected.amount &&
    data.currency === expected.currency
  );
}

export async function createPayment(input: CreatePaymentInput) {
  const plan = getPaymentPlan(input.planKey);
  const txRef = createTxRef(input.userId);
  const redirectUrl = getPaymentRedirectUrl(txRef);
  const idempotencyKey = createIdempotencyKey(input.userId, txRef);
  const supabase = createServiceRoleClient();

  const { data: reservation, error: reserveError } = await supabase.rpc(
    "reserve_payment_checkout",
    {
      p_user_id: input.userId,
      p_tx_ref: txRef,
      p_idempotency_key: idempotencyKey,
      p_plan_key: plan.key,
      p_plan_name: plan.name,
      p_amount: plan.amount,
      p_currency: plan.currency,
      p_customer_email: input.email,
      p_metadata: { plan_name: plan.name, duration_days: plan.durationDays },
    } as never,
  );
  if (reserveError) {
    console.error("payment_reservation_failed", reserveError);
    throw new Error("Could not reserve payment checkout.");
  }
  const reserved = reservation as {
    created?: boolean;
    tx_ref?: string;
    checkout_url?: string | null;
  } | null;
  if (!reserved?.tx_ref) throw new Error("Could not reserve payment checkout.");
  if (!reserved.created) {
    if (reserved.checkout_url) {
      if (!isTrustedFlutterwaveCheckoutUrl(reserved.checkout_url)) {
        throw new Error("Stored checkout link is invalid. Contact support.");
      }
      return {
        state: "resume" as const,
        txRef: reserved.tx_ref,
        checkoutUrl: reserved.checkout_url,
        plan,
      };
    }
    return {
      state: "pending" as const,
      txRef: reserved.tx_ref,
      checkoutUrl: null,
      plan,
    };
  }

  let checkout;
  try {
    checkout = await createFlutterwaveCheckout({
      txRef,
      amount: plan.amount,
      currency: plan.currency,
      redirectUrl,
      customer: {
        email: input.email,
        name: input.name,
        phonenumber: input.phone,
      },
      customizations: {
        title: siteConfig.name,
        description: plan.description,
        logo: `${siteConfig.url}/favicons/android-chrome-192x192.png`,
      },
      meta: {
        user_id: input.userId,
        plan_key: plan.key,
        idempotency_key: idempotencyKey,
      },
    });
  } catch (error) {
    // A timeout is not proof that Flutterwave rejected the request. Keep the
    // reserved reference for reconciliation; never issue a second one here.
    console.error("payment_checkout_uncertain", error);
    return { state: "pending" as const, txRef, checkoutUrl: null, plan };
  }

  const checkoutUrl = checkout.data?.link;
  if (checkout.status !== "success" || !checkoutUrl) {
    const { error: failureUpdateError } = await supabase
      .from("payments")
      .update({
        status: "failed",
        payment_link: null,
        failure_reason: checkout.message || "Flutterwave checkout failed.",
        provider_response: checkout,
      } as never)
      .eq("tx_ref", txRef);
    if (failureUpdateError) {
      console.error(
        "payment_checkout_failure_update_failed",
        failureUpdateError,
      );
      return { state: "pending" as const, txRef, checkoutUrl: null, plan };
    }
    throw new Error("Could not start Flutterwave checkout.");
  }
  if (!isTrustedFlutterwaveCheckoutUrl(checkoutUrl)) {
    console.error("payment_checkout_untrusted_url", { txRef });
    throw new Error("Flutterwave returned an invalid checkout link.");
  }

  const { error: updateError } = await supabase
    .from("payments")
    .update({
      checkout_url: checkoutUrl,
      payment_link: checkoutUrl,
      provider_response: checkout,
    } as never)
    .eq("tx_ref", txRef);

  if (updateError) {
    console.error("payment_checkout_update_failed", updateError);
    throw new Error(
      "Could not save checkout link. Check payment status before retrying.",
    );
  }

  return { state: "ready" as const, txRef, checkoutUrl, plan };
}

export async function verifyAndActivatePayment(
  transactionId: string,
  expected?: { userId?: string; txRef?: string },
): Promise<VerificationResult> {
  if (expected?.userId && expected.txRef) {
    const supabase = createServiceRoleClient();
    const { data, error } = await supabase
      .from("payments")
      .select("id")
      .eq("tx_ref", expected.txRef)
      .eq("user_id", expected.userId)
      .maybeSingle();
    if (error)
      return {
        success: false,
        state: "pending",
        error: "verification_unavailable",
      };
    if (!data)
      return { success: false, state: "failed", error: "payment_not_found" };
  }
  let verification: FlutterwaveVerificationResponse;
  try {
    verification = await verifyFlutterwaveTransaction(transactionId);
  } catch (error) {
    console.error("payment_provider_verify_unavailable", error);
    return {
      success: false,
      state: "pending",
      txRef: expected?.txRef,
      error: "verification_unavailable",
    };
  }
  return activateVerifiedPayment(verification, expected);
}

export async function verifyAndActivatePaymentByReference(
  txRef: string,
  userId?: string,
): Promise<VerificationResult> {
  const supabase = createServiceRoleClient();
  if (userId) {
    const { data: ownedPayment, error: ownedPaymentError } = await supabase
      .from("payments")
      .select("tx_ref, status, processed_at")
      .eq("tx_ref", txRef)
      .eq("user_id", userId)
      .maybeSingle();
    if (ownedPaymentError) {
      console.error("payment_ownership_lookup_failed", ownedPaymentError);
      return {
        success: false,
        state: "pending",
        txRef,
        error: "verification_unavailable",
      };
    }
    if (!ownedPayment) {
      return { success: false, state: "failed", error: "payment_not_found" };
    }
    if (ownedPayment.status === "successful" && ownedPayment.processed_at) {
      return { success: true, state: "success", txRef, alreadyProcessed: true };
    }
  }
  let verification: FlutterwaveVerificationResponse;
  try {
    verification = await verifyFlutterwaveTransactionByReference(txRef);
  } catch (error) {
    console.warn("payment_reference_verify_unavailable", { txRef, error });
    return {
      success: false,
      state: "pending",
      txRef,
      error: "verification_unavailable",
    };
  }
  return activateVerifiedPayment(verification, { userId, txRef });
}

async function activateVerifiedPayment(
  verification: FlutterwaveVerificationResponse,
  expected?: { userId?: string; txRef?: string },
): Promise<VerificationResult> {
  const supabase = createServiceRoleClient();
  const data = verification.data;

  if (!data?.tx_ref) {
    return {
      success: false,
      state: "pending",
      txRef: expected?.txRef,
      error: "missing_tx_ref",
    };
  }

  if (expected?.txRef && data.tx_ref !== expected.txRef) {
    console.warn("payment_verify_tx_ref_mismatch", {
      expectedTxRef: expected.txRef,
      actualTxRef: data.tx_ref,
    });
    return {
      success: false,
      state: "failed",
      txRef: expected.txRef,
      error: "tx_ref_mismatch",
    };
  }

  const { data: payment, error: paymentError } = await supabase
    .from("payments")
    .select(
      "tx_ref, user_id, amount, currency, status, processed_at, verification_attempts",
    )
    .eq("tx_ref", data.tx_ref)
    .maybeSingle();

  if (paymentError || !payment) {
    console.warn("payment_verify_unknown_tx_ref", {
      txRef: data.tx_ref,
      paymentError,
    });
    return {
      success: false,
      state: "pending",
      txRef: data.tx_ref,
      error: paymentError ? "verification_unavailable" : "payment_not_found",
    };
  }

  if (expected?.userId && payment.user_id !== expected.userId) {
    console.warn("payment_verify_user_mismatch", {
      txRef: data.tx_ref,
      expectedUserId: expected.userId,
    });
    return {
      success: false,
      state: "failed",
      txRef: data.tx_ref,
      error: "payment_not_found",
    };
  }

  if (payment.status === "successful" && payment.processed_at) {
    return {
      success: true,
      state: "success",
      txRef: data.tx_ref,
      alreadyProcessed: true,
    };
  }

  const detailsMatch =
    data.tx_ref === payment.tx_ref &&
    Number(data.amount) === Number(payment.amount) &&
    data.currency === payment.currency;
  if (!detailsMatch || !Number.isSafeInteger(data.id) || data.id <= 0) {
    console.error("payment_provider_details_mismatch", {
      txRef: payment.tx_ref,
      providerId: data.id,
    });
    return {
      success: false,
      state: "pending",
      txRef: payment.tx_ref,
      error: "details_mismatch",
    };
  }

  if (
    !isVerifiedSuccessfulPayment(verification, {
      txRef: payment.tx_ref,
      amount: Number(payment.amount),
      currency: payment.currency,
    })
  ) {
    const terminal =
      verification.status === "success" &&
      (data.status === "failed" || data.status === "cancelled");
    if (!terminal) {
      return {
        success: false,
        state: "pending",
        txRef: data.tx_ref,
        error: "payment_pending",
      };
    }
    const { error: updateError } = await supabase
      .from("payments")
      .update({
        status: data.status === "cancelled" ? "cancelled" : "failed",
        failure_reason: verification.message || "Verification failed.",
        provider_response: verification,
        verification_attempts: Number(payment.verification_attempts ?? 0) + 1,
        verified_at: new Date().toISOString(),
      } as never)
      .eq("tx_ref", data.tx_ref)
      .neq("status", "successful");
    if (updateError) {
      console.error("payment_terminal_update_failed", updateError);
      return {
        success: false,
        state: "pending",
        txRef: data.tx_ref,
        error: "processing_failed",
      };
    }

    return {
      success: false,
      state: "failed",
      txRef: data.tx_ref,
      error: data.status,
    };
  }

  const { data: processResult, error: processError } = await supabase.rpc(
    "process_successful_payment",
    {
      p_tx_ref: data.tx_ref,
      p_flutterwave_transaction_id: data.id,
      p_provider_response: verification,
      p_verified_at: new Date().toISOString(),
    } as never,
  );

  if (processError) {
    console.error("payment_process_failed", processError);
    return {
      success: false,
      state: "pending",
      txRef: data.tx_ref,
      error: "processing_failed",
    };
  }

  const result = processResult as {
    success?: boolean;
    already_processed?: boolean;
    error?: string;
  } | null;

  // This RPC is idempotent: a student can only convert once. Keep it after
  // payment activation so no referral is rewarded for an unverified checkout.
  if (result?.success === true) {
    const { error: commissionError } = await supabase.rpc(
      "award_partner_commission_for_payment",
      { p_user_id: payment.user_id } as never,
    );
    if (commissionError) {
      // Payment remains valid; the conversion stays unclaimed and can be
      // retried safely on a later verified payment request.
      console.error("partner_commission_award_failed", commissionError);
    }
  }

  return {
    success: result?.success === true,
    state: result?.success === true ? "success" : "pending",
    txRef: data.tx_ref,
    alreadyProcessed: result?.already_processed === true,
    error: result?.error,
  };
}

export async function rememberWebhookEvent(
  eventKey: string,
  payload: unknown,
  txRef?: string,
  transactionId?: number,
) {
  const supabase = createServiceRoleClient();
  const { error } = await supabase.from("payment_webhook_events").insert({
    event_key: eventKey,
    tx_ref: txRef,
    flutterwave_transaction_id: transactionId,
    payload,
  } as never);

  if (error?.code === "23505") {
    const { data, error: lookupError } = await supabase
      .from("payment_webhook_events")
      .select("processed_at")
      .eq("provider", "flutterwave")
      .eq("event_key", eventKey)
      .single();
    if (lookupError) throw lookupError;
    return !data?.processed_at;
  }
  if (error) {
    console.error("payment_webhook_event_insert_failed", error);
    throw error;
  }
  return true;
}

export async function markWebhookEventProcessed(eventKey: string) {
  const supabase = createServiceRoleClient();
  const { error } = await supabase
    .from("payment_webhook_events")
    .update({ processed_at: new Date().toISOString() } as never)
    .eq("provider", "flutterwave")
    .eq("event_key", eventKey);
  if (error) throw error;
}
