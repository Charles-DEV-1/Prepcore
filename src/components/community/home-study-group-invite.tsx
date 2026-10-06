import { ArrowUpRight, BookOpenCheck, MessageCircleMore } from "lucide-react";
import { WHATSAPP_STUDY_GROUP_URL } from "@/config/community";

export function HomeStudyGroupInvite() {
  return (
    <section
      aria-labelledby="home-study-group-title"
      className="bg-white px-4 py-10 dark:bg-[#0B1220] sm:py-14"
    >
      <div className="container">
        <a
          href={WHATSAPP_STUDY_GROUP_URL}
          target="_blank"
          rel="noopener noreferrer"
          className="group relative block overflow-hidden rounded-[2rem] border border-emerald-200 bg-gradient-to-br from-emerald-50 via-white to-blue-50 p-6 text-slate-900 shadow-[0_14px_40px_rgba(15,118,110,0.09)] transition-[border-color,box-shadow,transform] duration-300 hover:border-emerald-400 hover:shadow-[0_22px_55px_rgba(15,118,110,0.18)] focus-visible:outline-none focus-visible:ring-4 focus-visible:ring-emerald-500/60 dark:border-emerald-800/70 dark:from-[#102820] dark:via-[#152b2b] dark:to-[#172842] dark:text-slate-100 dark:hover:border-emerald-500 sm:p-9 motion-safe:hover:-translate-y-1 motion-reduce:transition-none"
        >
          <span
            aria-hidden="true"
            className="pointer-events-none absolute -right-16 -top-20 h-64 w-64 rounded-full bg-[radial-gradient(circle,rgba(110,231,183,0.32)_0%,transparent_70%)] transition-transform duration-500 motion-safe:group-hover:-translate-x-8 motion-safe:group-hover:translate-y-6 dark:bg-[radial-gradient(circle,rgba(16,185,129,0.18)_0%,transparent_70%)]"
          />
          <span
            aria-hidden="true"
            className="pointer-events-none absolute -bottom-24 left-1/3 h-48 w-48 rounded-full bg-[radial-gradient(circle,rgba(147,197,253,0.28)_0%,transparent_70%)] transition-transform duration-500 motion-safe:group-hover:translate-x-8 dark:bg-[radial-gradient(circle,rgba(59,130,246,0.13)_0%,transparent_70%)]"
          />

          <div className="relative grid items-center gap-6 md:grid-cols-[auto_minmax(0,1fr)_auto] md:gap-8">
            <span className="grid h-16 w-16 place-items-center rounded-2xl bg-emerald-800 text-white shadow-[0_10px_25px_rgba(6,95,70,0.2)] transition-transform duration-300 motion-safe:group-hover:-rotate-6 motion-safe:group-hover:scale-110 motion-safe:group-focus-visible:-rotate-6 motion-safe:group-focus-visible:scale-110 dark:bg-emerald-700">
              <MessageCircleMore className="h-8 w-8" aria-hidden="true" />
            </span>

            <div>
              <p className="text-xs font-bold uppercase tracking-[0.18em] text-emerald-800 dark:text-emerald-200">
                Free study community
              </p>
              <h2
                id="home-study-group-title"
                className="mt-2 text-2xl font-bold tracking-tight sm:text-3xl"
              >
                Questions are better when we work through them together.
              </h2>
              <p className="mt-2 max-w-2xl text-sm leading-6 text-slate-700 dark:text-slate-300 sm:text-base">
                Join the Prepcore WhatsApp group for JAMB and WAEC practice
                questions, answer discussions, and topics to revisit.
              </p>
              <p className="mt-3 flex items-center gap-2 text-xs font-medium text-emerald-900 dark:text-emerald-200">
                <BookOpenCheck className="h-4 w-4" aria-hidden="true" />
                Optional to join · Your number may be visible to group members
              </p>
            </div>

            <span className="inline-flex min-h-12 items-center justify-center gap-2 self-start rounded-xl bg-emerald-800 px-5 py-3 text-sm font-bold text-white shadow-sm transition-[background-color,box-shadow] duration-300 group-hover:bg-emerald-900 group-hover:shadow-lg group-focus-visible:bg-emerald-900 dark:bg-emerald-700 dark:group-hover:bg-emerald-600 dark:group-focus-visible:bg-emerald-600 md:self-center">
              Join the group
              <ArrowUpRight
                className="h-4 w-4 transition-transform duration-300 motion-safe:group-hover:-translate-y-1 motion-safe:group-hover:translate-x-1 motion-safe:group-focus-visible:-translate-y-1 motion-safe:group-focus-visible:translate-x-1"
                aria-hidden="true"
              />
              <span className="sr-only">(opens in a new tab)</span>
            </span>
          </div>
        </a>
      </div>
    </section>
  );
}
