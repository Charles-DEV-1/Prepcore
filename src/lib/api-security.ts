import { NextResponse } from "next/server";

const MAX_JSON_BYTES = 24 * 1024;

export function noStoreJson(body: unknown, init?: ResponseInit) {
  const response = NextResponse.json(body, init);
  response.headers.set("Cache-Control", "no-store, max-age=0");
  response.headers.set("Pragma", "no-cache");
  return response;
}

// Browser mutation routes require same-origin provenance. Webhooks do not use
// this helper; they authenticate with their provider signatures instead.
export function hasTrustedOrigin(request: Request) {
  const origin = request.headers.get("origin");
  const referer = request.headers.get("referer");
  const source = origin ?? referer;
  if (!source) return request.headers.get("sec-fetch-site") === "same-origin";
  try {
    const parsed = new URL(source);
    return parsed.origin === new URL(request.url).origin;
  } catch {
    return false;
  }
}

// Enforce the limit while reading, since Content-Length can be omitted or
// incorrect (for example with chunked transfer encoding).
export async function readBoundedText(
  request: Request,
  maxBytes: number,
): Promise<string | null> {
  const lengthHeader = request.headers.get("content-length");
  if (lengthHeader !== null) {
    const declaredLength = Number(lengthHeader);
    if (!Number.isSafeInteger(declaredLength) || declaredLength < 0 || declaredLength > maxBytes)
      return null;
  }

  if (!request.body) return null;
  const reader = request.body.getReader();
  const decoder = new TextDecoder();
  let bytesRead = 0;
  let body = "";
  try {
    while (true) {
      const { done, value } = await reader.read();
      if (done) break;
      bytesRead += value.byteLength;
      if (bytesRead > maxBytes) {
        await reader.cancel().catch(() => undefined);
        return null;
      }
      body += decoder.decode(value, { stream: true });
    }
    return body + decoder.decode();
  } finally {
    reader.releaseLock();
  }
}

export async function readSafeJson<T>(request: Request): Promise<T | null> {
  const text = await readBoundedText(request, MAX_JSON_BYTES);
  if (text === null) return null;
  try {
    return JSON.parse(text) as T;
  } catch {
    return null;
  }
}
