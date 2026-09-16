"use client";

// Prepcore — Dark Mode
import { ThemeProvider } from "@/components/theme-provider";
import { QueryProvider } from "@/providers/query-provider";
import { PwaRuntime } from "@/components/pwa-runtime";

export function AppProviders({ children }: { children: React.ReactNode }) {
  return (
    <ThemeProvider
      attribute="class"
      defaultTheme="dark"
      storageKey="prepcore_theme"
      enableSystem={false}
      disableTransitionOnChange
    >
      <QueryProvider>
        <PwaRuntime />
        {children}
      </QueryProvider>
    </ThemeProvider>
  );
}
