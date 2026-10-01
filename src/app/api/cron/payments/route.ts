import { noStoreJson } from "@/lib/api-security";
import { verifyAndActivatePaymentByReference } from "@/services/payments/payment-service";
import { createServiceRoleClient } from "@/services/supabase/admin";

export const runtime = "nodejs";
export const maxDuration = 60;

export async function GET(request: Request) {
  const secret = process.env.CRON_SECRET;
  if (!secret || request.headers.get("authorization") !== `Bearer ${secret}`) {
    return noStoreJson({ error: "Unauthorized." }, { status: 401 });
  }

  const admin = createServiceRoleClient();
  const { data: payments, error } = await admin
    .from("payments")
    .select("tx_ref")
    .in("status", ["pending", "failed", "cancelled"])
    .is("processed_at", null)
    .lte("created_at", new Date(Date.now() - 2 * 60_000).toISOString())
    .gte(
      "created_at",
      new Date(Date.now() - 30 * 24 * 60 * 60_000).toISOString(),
    )
    .order("last_reconciled_at", { ascending: true, nullsFirst: true })
    .limit(8);
  if (error) {
    console.error("payments_reconciliation_query_failed", error);
    return noStoreJson(
      { error: "Payment reconciliation unavailable." },
      { status: 500 },
    );
  }

  const results = await Promise.allSettled(
    (payments ?? []).map(async ({ tx_ref }) => {
      // Updating before the provider request avoids repeatedly selecting one
      // unresolved attempt while other attempts wait their turn.
      const { error: updateError } = await admin
        .from("payments")
        .update({ last_reconciled_at: new Date().toISOString() } as never)
        .eq("tx_ref", tx_ref);
      if (updateError) throw updateError;
      return verifyAndActivatePaymentByReference(tx_ref);
    }),
  );
  const completed = results.flatMap((result) =>
    result.status === "fulfilled" ? [result.value] : [],
  );
  const errors = results.filter((result) => result.status === "rejected");
  if (errors.length)
    console.error("payments_reconciliation_failed", { count: errors.length });
  return noStoreJson(
    {
      checked: completed.length,
      activated: completed.filter((result) => result.success).length,
      unresolved: completed.filter((result) => result.state === "pending")
        .length,
      failed: errors.length,
    },
    { status: errors.length ? 500 : 200 },
  );
}
