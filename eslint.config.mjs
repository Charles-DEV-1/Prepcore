import { defineConfig, globalIgnores } from "eslint/config";
import nextVitals from "eslint-config-next/core-web-vitals";
import nextTypescript from "eslint-config-next/typescript";

const eslintConfig = defineConfig([
  ...nextVitals,
  ...nextTypescript,
  {
    rules: {
      // Existing effects/memoization predate this security upgrade. Migrate
      // them separately rather than allowing unrelated UI rewrites here.
      "react-hooks/set-state-in-effect": "off",
      "react-hooks/preserve-manual-memoization": "off",
    },
  },
  globalIgnores([".next/**", "node_modules/**", "out/**", "dist/**", "coverage/**", "next-env.d.ts", ".codex-notification-backup-20260921/**", "supabase/.temp/**"]),
]);

export default eslintConfig;
