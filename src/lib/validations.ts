import { z } from "zod";

export const emailAuthSchema = z.object({
  email: z.string().trim().email("Enter a valid email address"),
});

export const emailOtpSchema = z.object({
  email: z.string().trim().email(),
  token: z.string().regex(/^\d{6}$/, "Enter the 6-digit code"),
});

export const onboardingSchema = z
  .object({
    fullName: z
      .string()
      .trim()
      .min(2, "Tell us the name you would like us to use")
      .max(30, "Keep your name under 30 characters"),
    examType: z.enum(["jamb", "waec"]),
    examGoals: z
      .array(z.enum(["jamb", "waec"]))
      .min(1, "Choose at least one exam")
      .max(2),
    subjects: z
      .array(z.string().trim().min(1).max(120))
      .min(1, "Select at least one subject")
      .max(20, "Choose up to 20 subjects"),
    targetScore: z.number().int().min(1).max(400).nullable(),
    examDate: z.string().refine((value) => {
      if (!value) return true;
      if (!/^\d{4}-\d{2}-\d{2}$/.test(value)) return false;
      const date = new Date(`${value}T00:00:00.000Z`);
      return (
        !Number.isNaN(date.getTime()) &&
        date.toISOString().slice(0, 10) === value
      );
    }, "Choose a valid exam date"),
    referralCode: z
      .string()
      .trim()
      .refine(
        (v) => v === "" || /^[A-Za-z0-9-]+$/.test(v),
        "Use letters, numbers, and hyphens only",
      ),
  })
  .superRefine((values, context) => {
    if (!values.examGoals.includes(values.examType)) {
      context.addIssue({
        code: z.ZodIssueCode.custom,
        path: ["examGoals"],
        message: "Choose an exam that matches your plan",
      });
    }
    if (new Set(values.examGoals).size !== values.examGoals.length) {
      context.addIssue({
        code: z.ZodIssueCode.custom,
        path: ["examGoals"],
        message: "Choose each exam only once",
      });
    }
    if (!values.examGoals.includes("jamb") && values.targetScore !== null) {
      context.addIssue({
        code: z.ZodIssueCode.custom,
        path: ["targetScore"],
        message: "A JAMB target score needs a JAMB study goal",
      });
    }
  });

export type EmailAuthValues = z.infer<typeof emailAuthSchema>;
export type EmailOtpValues = z.infer<typeof emailOtpSchema>;
export type OnboardingValues = z.infer<typeof onboardingSchema>;
