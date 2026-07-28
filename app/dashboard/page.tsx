export default function DashboardPage() {
  return (
    <div className="flex flex-col gap-6">
      {/* Header section */}
      <div>
        <h2 className="text-2xl font-bold tracking-tight">Executive Control Centre</h2>
        <p className="text-zinc-500 text-sm">Real-time status monitor of Strategic Minds APEX advisory system.</p>
      </div>

      {/* KPI Tiles Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="bg-white p-6 rounded-lg border border-zinc-200 shadow-sm flex flex-col justify-between h-36">
          <div className="text-zinc-400 font-semibold uppercase tracking-wider text-xs">APEX System Health</div>
          <div className="text-3xl font-extrabold">100.0%</div>
          <div className="text-emerald-500 text-xs font-semibold flex items-center gap-1">
            <span>●</span> Synchronized with Core OS
          </div>
        </div>

        <div className="bg-white p-6 rounded-lg border border-zinc-200 shadow-sm flex flex-col justify-between h-36 border-l-4 border-l-[#f8b800]">
          <div className="text-zinc-400 font-semibold uppercase tracking-wider text-xs">Replication Hub</div>
          <div className="text-3xl font-extrabold">09-SYNC</div>
          <div className="text-zinc-500 text-xs flex items-center gap-1">
            Active: Google Drive Container
          </div>
        </div>

        <div className="bg-white p-6 rounded-lg border border-zinc-200 shadow-sm flex flex-col justify-between h-36">
          <div className="text-zinc-400 font-semibold uppercase tracking-wider text-xs">Vercel Deploy Status</div>
          <div className="text-3xl font-extrabold">Edge Live</div>
          <div className="text-emerald-500 text-xs font-semibold flex items-center gap-1">
            <span>●</span> Continuous delivery online
          </div>
        </div>
      </div>

      {/* Main advisory card */}
      <div className="bg-[#000000] text-white p-8 rounded-lg border border-[#f8b800]/20 shadow-lg mt-4">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
          <div className="flex flex-col gap-2">
            <div className="inline-block px-3 py-1 rounded bg-[#f8b800]/20 text-[#f8b800] text-[10px] uppercase tracking-widest font-bold self-start">
              Strategic Minds Core Standard
            </div>
            <h3 className="text-xl font-bold tracking-tight">Autonomous Advisory Framework</h3>
            <p className="text-zinc-400 text-sm max-w-xl">
              APEX works in the background monitoring client files on Drive, triggering checks across the GitHub pipeline, and compiling strategic advice metrics for high-trust executive decision making.
            </p>
          </div>
          <button className="bg-[#f8b800] text-black hover:bg-[#e0a600] px-6 py-3 rounded font-bold text-sm transition shrink-0">
            Access Advisor Portal
          </button>
        </div>
      </div>
    </div>
  );
}
