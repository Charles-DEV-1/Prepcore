import { Skeleton } from "@/components/ui/skeleton";

type PageSkeletonProps = {
  variant?: "dashboard" | "form" | "practice" | "analytics";
};

export function PageSkeleton({ variant = "dashboard" }: PageSkeletonProps) {
  if (variant === "practice") {
    return (
      <div
        className="space-y-5"
        aria-label="Loading practice session"
        role="status"
      >
        <div className="flex items-center justify-between gap-4">
          <div className="space-y-2">
            <Skeleton className="h-7 w-36" />
            <Skeleton className="h-4 w-52" />
          </div>
          <Skeleton className="h-9 w-24" />
        </div>
        <Skeleton className="h-2 w-full rounded-full" />
        <div className="space-y-6 rounded-2xl border border-border bg-card p-6 dark:border-border-card dark:bg-card-surface">
          <Skeleton className="h-6 w-32" />
          <Skeleton className="h-8 w-11/12" />
          <Skeleton className="h-6 w-4/5" />
          <div className="space-y-3 pt-2">
            {[0, 1, 2, 3].map((item) => (
              <Skeleton key={item} className="h-14 w-full" />
            ))}
          </div>
        </div>
      </div>
    );
  }

  if (variant === "form") {
    return (
      <div
        className="mx-auto max-w-2xl space-y-6"
        aria-label="Loading profile"
        role="status"
      >
        <div className="space-y-2">
          <Skeleton className="h-8 w-28" />
          <Skeleton className="h-4 w-56" />
        </div>
        <Skeleton className="h-44 w-full" />
        <div className="space-y-5 rounded-2xl border border-border bg-card p-6 dark:border-border-card dark:bg-card-surface">
          <Skeleton className="h-6 w-40" />
          <Skeleton className="h-10 w-full" />
          <Skeleton className="h-10 w-full" />
          <Skeleton className="h-10 w-32" />
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6" aria-label="Loading page" role="status">
      <div className="space-y-2">
        <Skeleton className="h-8 w-48" />
        <Skeleton className="h-4 w-72" />
      </div>
      <div className="grid gap-4 md:grid-cols-3">
        <Skeleton className="h-40" />
        <Skeleton className="h-40" />
        <Skeleton className="h-40" />
      </div>
      <Skeleton className="h-80 w-full" />
    </div>
  );
}
