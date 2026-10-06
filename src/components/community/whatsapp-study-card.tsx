import { ArrowUpRight, BookOpenText, MessageCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { WHATSAPP_STUDY_GROUP_URL } from "@/config/community";

export function WhatsAppStudyCard() {
  return (
    <Card className="w-full border-emerald-200 bg-white shadow-soft dark:border-emerald-700/50 dark:bg-card-surface">
      <CardContent className="space-y-5 p-6 sm:p-8">
        <div className="flex items-center gap-3">
          <span className="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-emerald-100 text-emerald-800 dark:bg-emerald-900/50 dark:text-emerald-200">
            <MessageCircle className="h-6 w-6" aria-hidden="true" />
          </span>
          <p className="text-sm font-bold uppercase tracking-wide text-emerald-800 dark:text-emerald-200">
            Free Prepcore study group
          </p>
        </div>

        <div>
          <h2 className="text-2xl font-bold text-slate-900 dark:text-slate-100">
            Keep learning together on WhatsApp
          </h2>
          <p className="mt-2 text-sm leading-6 text-slate-700 dark:text-slate-300">
            Join other JAMB and WAEC learners. We&apos;ll share practice
            questions, work through the answers, and discuss topics worth
            revisiting. You don&apos;t need Pro to join.
          </p>
        </div>

        <div className="flex items-start gap-2 rounded-xl bg-emerald-50 p-3 text-sm text-emerald-950 dark:bg-emerald-950/40 dark:text-emerald-100">
          <BookOpenText className="mt-0.5 h-4 w-4 shrink-0" aria-hidden="true" />
          <p>Learn why an answer fits, not just which option is correct.</p>
        </div>

        <Button
          asChild
          className="w-full bg-emerald-800 text-white hover:bg-emerald-900 dark:bg-emerald-700 dark:text-white dark:hover:bg-emerald-800"
        >
          <a
            href={WHATSAPP_STUDY_GROUP_URL}
            target="_blank"
            rel="noopener noreferrer"
          >
            Join the WhatsApp group
            <ArrowUpRight className="h-4 w-4" aria-hidden="true" />
            <span className="sr-only">(opens in a new tab)</span>
          </a>
        </Button>

        <p className="text-xs leading-5 text-slate-600 dark:text-slate-300">
          Joining is optional. WhatsApp opens separately, and your phone number
          may be visible to other group members.
        </p>
      </CardContent>
    </Card>
  );
}
