import { PracticePage } from "@/features/practice/practice-page";

export default async function PracticeRoute({
  searchParams,
}: {
  searchParams: Promise<{ exam?: string; subject?: string; topic?: string }>;
}) {
  const params = await searchParams;
  const recommendation =
    (params.exam === "jamb" || params.exam === "waec") &&
    typeof params.subject === "string" &&
    /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(
      params.subject,
    ) &&
    typeof params.topic === "string" &&
    params.topic.length > 0 &&
    params.topic.length <= 80
      ? {
          exam: params.exam as "jamb" | "waec",
          subjectId: params.subject,
          topic: params.topic,
        }
      : null;
  return <PracticePage recommendation={recommendation} />;
}
