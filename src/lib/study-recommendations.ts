export type RecommendationEvidence = {
  questionId: string;
  subjectId: string;
  subject: string;
  topic: string;
  correct: boolean;
  answeredAt: string;
};

export type StudyRecommendation = {
  subjectId: string;
  subject: string;
  topic: string;
  answered: number;
  missed: number;
  accuracy: number;
  kind: "focus" | "check" | "refresh";
  reason: string;
};

const MAX_TOPIC_LENGTH = 80;
const REVIEW_AFTER_DAYS = 14;

export function cleanTopicLabel(value: string | null | undefined) {
  if (!value) return null;
  const topic = value
    .replace(/<[^>]*>/g, " ")
    .replace(/&nbsp;/gi, " ")
    .replace(/&amp;/gi, "&")
    .replace(/\s+/g, " ")
    .trim();
  if (
    !topic ||
    topic.length > MAX_TOPIC_LENGTH ||
    /<|>|\bthese questions\b|\bif our thoughts\b/i.test(value)
  )
    return null;
  return topic;
}

/** One latest answer per question avoids retries inflating a topic's evidence. */
export function buildStudyRecommendations(
  evidence: RecommendationEvidence[],
  now = new Date(),
): StudyRecommendation[] {
  const latest = new Map<string, RecommendationEvidence>();
  for (const answer of evidence) {
    const previous = latest.get(answer.questionId);
    if (!previous || answer.answeredAt > previous.answeredAt) {
      latest.set(answer.questionId, answer);
    }
  }

  const groups = new Map<
    string,
    {
      subjectId: string;
      subject: string;
      topic: string;
      answered: number;
      missed: number;
      latestAt: string;
    }
  >();
  for (const answer of latest.values()) {
    const topic = cleanTopicLabel(answer.topic);
    if (!topic || !answer.subjectId || !answer.subject) continue;
    // Keep the raw topic for exact database filtering; display uses the safe label.
    const key = `${answer.subjectId}:${answer.topic}`;
    const group = groups.get(key) ?? {
      subjectId: answer.subjectId,
      subject: answer.subject,
      topic: answer.topic,
      answered: 0,
      missed: 0,
      latestAt: answer.answeredAt,
    };
    group.answered++;
    if (!answer.correct) group.missed++;
    if (answer.answeredAt > group.latestAt) group.latestAt = answer.answeredAt;
    groups.set(key, group);
  }

  return [...groups.values()]
    .flatMap((group) => {
      const accuracy = Math.round((1 - group.missed / group.answered) * 100);
      const daysSince = Math.max(
        0,
        Math.floor(
          (now.getTime() - new Date(group.latestAt).getTime()) / 86_400_000,
        ),
      );
      let kind: StudyRecommendation["kind"];
      let reason: string;
      if (group.answered >= 3 && accuracy < 70) {
        kind = "focus";
        reason = `You missed ${group.missed} of ${group.answered} recent questions in this topic.`;
      } else if (group.answered < 3 && group.missed > 0) {
        kind = "check";
        reason = `You missed ${group.missed} of ${group.answered}. Try a few more to confirm whether this needs work.`;
      } else if (group.answered >= 3 && daysSince >= REVIEW_AFTER_DAYS) {
        kind = "refresh";
        reason = `You last practised this topic ${daysSince} days ago. A short review can keep it fresh.`;
      } else {
        return [];
      }
      return [{ ...group, accuracy, kind, reason }];
    })
    .sort((a, b) => {
      const priority = { focus: 0, check: 1, refresh: 2 };
      return (
        priority[a.kind] - priority[b.kind] ||
        a.accuracy - b.accuracy ||
        b.answered - a.answered
      );
    })
    .slice(0, 3);
}
