import assert from "node:assert/strict";
import Module from "node:module";
import { dirname } from "node:path";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import test from "node:test";
import typescript from "typescript";

const file = fileURLToPath(new URL("./api-security.ts", import.meta.url));
const compiled = typescript.transpileModule(readFileSync(file, "utf8"), {
  compilerOptions: {
    module: typescript.ModuleKind.CommonJS,
    target: typescript.ScriptTarget.ES2022,
  },
}).outputText;
const compiledModule = new Module(file);
compiledModule.filename = file;
compiledModule.paths = Module._nodeModulePaths(dirname(file));
compiledModule._compile(compiled, file);
const { hasTrustedOrigin, readBoundedText, readSafeJson } = compiledModule.exports;

const url = "https://prepcore.example/api/test";
const post = (headers, body) => new Request(url, { method: "POST", headers, body });

test("browser mutations require trustworthy same-origin provenance", () => {
  assert.equal(hasTrustedOrigin(post({ origin: "https://prepcore.example" })), true);
  assert.equal(hasTrustedOrigin(post({ origin: "https://attacker.example" })), false);
  assert.equal(hasTrustedOrigin(post({ referer: "https://prepcore.example/page" })), true);
  assert.equal(hasTrustedOrigin(post({ referer: "https://attacker.example/page" })), false);
  assert.equal(hasTrustedOrigin(post({})), false);
  assert.equal(hasTrustedOrigin(post({ "sec-fetch-site": "cross-site" })), false);
  assert.equal(hasTrustedOrigin(post({ "sec-fetch-site": "same-origin" })), true);
  assert.equal(
    hasTrustedOrigin(post({ origin: "https://attacker.example", referer: "https://prepcore.example/page" })),
    false,
  );
});

test("request bodies are limited by actual bytes even without Content-Length", async () => {
  assert.equal(await readBoundedText(post({}, "1234"), 4), "1234");
  assert.equal(await readBoundedText(post({}, "12345"), 4), null);
  assert.equal(await readBoundedText(post({ "content-length": "999" }, "ok"), 4), null);

  const chunkedBody = new ReadableStream({
    start(controller) {
      controller.enqueue(new Uint8Array([49, 50, 51]));
      controller.enqueue(new Uint8Array([52, 53]));
      controller.close();
    },
  });
  const chunkedRequest = new Request(url, { method: "POST", body: chunkedBody, duplex: "half" });
  assert.equal(await readBoundedText(chunkedRequest, 4), null);
  assert.deepEqual(await readSafeJson(post({}, JSON.stringify({ ok: true }))), { ok: true });
});
