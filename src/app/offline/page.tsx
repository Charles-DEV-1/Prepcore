import Image from "next/image";

// Prepcore - Online PWA foundation
export default function OfflinePage() {
  return (
    <main className="flex min-h-screen items-center justify-center bg-[#0F172A] px-6 text-center text-white">
      <div className="max-w-md">
        <Image
          src="/favicons/android-chrome-192x192.png"
          alt="Prepcore logo"
          width={96}
          height={96}
          className="mx-auto rounded-3xl"
          priority
        />
        <h1 className="mt-8 text-3xl font-bold">You&apos;re offline</h1>
        <p className="mt-3 leading-7 text-slate-300">
          Connect to the internet to continue using Prepcore. Your study tools
          will be ready when you&apos;re back online.
        </p>
      </div>
    </main>
  );
}
