import { NextRequest } from "next/server";
import { forbiddenResponse, getAdminSessionUser } from "@/lib/admin-api-auth";
import { hasTrustedOrigin, noStoreJson, readSafeJson } from "@/lib/api-security";
import { createServiceRoleClient } from "@/services/supabase/admin";
import { z } from "zod";

const updateSchema = z.object({ id: z.string().uuid(), status: z.enum(["active", "suspended"]) }).strict();

export async function GET(){if(!(await getAdminSessionUser()))return forbiddenResponse();const {data,error}=await createServiceRoleClient().from("partner_accounts").select("id,full_name,email,phone,business_name,city,partner_type,referral_code,status,total_earned,pending_balance,created_at").order("created_at",{ascending:false});if(error)return noStoreJson({error:"Could not load partners."},{status:500});return noStoreJson({partners:data??[]});}
export async function PATCH(request:NextRequest){if(!hasTrustedOrigin(request))return noStoreJson({error:"Invalid request origin."},{status:403});const adminUser=await getAdminSessionUser();if(!adminUser)return forbiddenResponse();const parsed=updateSchema.safeParse(await readSafeJson<unknown>(request));if(!parsed.success)return noStoreJson({error:"Invalid request"},{status:400});const {id,status}=parsed.data;const {error}=await createServiceRoleClient().from("partner_accounts").update({status,approved_at:status==="active"?new Date().toISOString():null,approved_by:adminUser.email} as never).eq("id",id);if(error)return noStoreJson({error:"Could not update partner."},{status:500});return noStoreJson({success:true});}
