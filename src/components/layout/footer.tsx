import Link from "next/link";
import Image from "next/image";
import { ArrowUpRight, MessageCircleMore } from "lucide-react";
import { WHATSAPP_STUDY_GROUP_URL } from "@/config/community";

// Prepcore — Dark Mode
export function Footer() {
  return (
    <footer className="border-t border-border bg-white dark:border-slate-800 dark:bg-[#0B1220]">
      <div className="container flex flex-col gap-5 py-8 text-sm text-slate-600 dark:text-slate-300 md:flex-row md:items-center md:justify-between">
        <div className="flex items-center gap-3">
          <Image
            src="/favicons/android-chrome-512x512.png"
            alt="Prepcore logo"
            width={48}
            height={48}
            className="rounded-full"
          />
          <p>
            © {new Date().getFullYear()} Prepcore. Built for Nigerian students.
          </p>
        </div>
        <div className="flex flex-col gap-3 md:items-end">
          <nav
            aria-label="Footer links"
            className="flex flex-wrap gap-x-5 gap-y-2"
          >
            <Link
              className="rounded-sm hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary dark:hover:text-blue-300"
              href="/login"
            >
              Login
            </Link>
            <Link
              className="rounded-sm hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary dark:hover:text-blue-300"
              href="/pricing"
            >
              Pricing
            </Link>
            <Link
              className="rounded-sm hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary dark:hover:text-blue-300"
              href="/privacy-policy"
            >
              Privacy Policy
            </Link>
            <a
              className="rounded-sm hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary dark:hover:text-blue-300"
              href="mailto:hello@prepcore.ng"
            >
              Contact
            </a>
          </nav>
          <nav
            aria-label="Prepcore social links"
            className="flex flex-wrap items-center gap-x-5 gap-y-2"
          >
            <a
              className="rounded-sm font-medium hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary dark:hover:text-blue-300"
              href="https://tiktok.com/@prepcoreng"
              target="_blank"
              rel="noopener noreferrer"
            >
              TikTok<span className="sr-only"> (opens in a new tab)</span>
            </a>
            <a
              className="rounded-sm font-medium hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary dark:hover:text-blue-300"
              href="https://instagram.com/prepcoreng"
              target="_blank"
              rel="noopener noreferrer"
            >
              Instagram<span className="sr-only"> (opens in a new tab)</span>
            </a>
            <a
              href={WHATSAPP_STUDY_GROUP_URL}
              target="_blank"
              rel="noopener noreferrer"
              className="group inline-flex min-h-10 items-center gap-2 rounded-full border border-emerald-200 bg-emerald-50 px-3 font-semibold text-emerald-900 shadow-sm transition-[border-color,background-color,box-shadow,transform] duration-300 hover:border-emerald-400 hover:bg-emerald-100 hover:shadow-[0_8px_20px_rgba(5,150,105,0.16)] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-emerald-600 dark:border-emerald-800 dark:bg-emerald-950/50 dark:text-emerald-200 dark:hover:border-emerald-500 dark:hover:bg-emerald-900/50 motion-safe:hover:-translate-y-0.5 motion-reduce:transition-none"
            >
              <MessageCircleMore
                className="h-4 w-4 transition-transform duration-300 motion-safe:group-hover:-rotate-12 motion-safe:group-hover:scale-110 motion-safe:group-focus-visible:-rotate-12 motion-safe:group-focus-visible:scale-110"
                aria-hidden="true"
              />
              WhatsApp study group
              <ArrowUpRight
                className="h-3.5 w-3.5 transition-transform duration-300 motion-safe:group-hover:-translate-y-0.5 motion-safe:group-hover:translate-x-0.5 motion-safe:group-focus-visible:-translate-y-0.5 motion-safe:group-focus-visible:translate-x-0.5"
                aria-hidden="true"
              />
              <span className="sr-only">(opens in a new tab)</span>
            </a>
          </nav>
        </div>
      </div>
    </footer>
  );
}
