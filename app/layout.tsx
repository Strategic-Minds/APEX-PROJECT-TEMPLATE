import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Strategic Minds APEX OS",
  description: "Elite Client Delivery Performance Board",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="font-sans antialiased bg-[#f0f0f0] text-[#1a1a1a] m-0 p-0 h-screen flex">
        {/* Core Strategic Minds Obsidian Sidebar (240px) */}
        <aside className="w-[240px] bg-[#000000] text-white flex flex-col justify-between p-6 shrink-0 h-full border-r border-[#f8b800]/20">
          <div className="flex flex-col gap-8">
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 rounded-md bg-[#f8b800] flex items-center justify-center font-bold text-black text-lg">
                S
              </div>
              <div>
                <h1 className="font-extrabold tracking-wider text-sm text-white">STRATEGIC</h1>
                <p className="text-[10px] text-[#f8b800] tracking-widest uppercase">MINDS APEX</p>
              </div>
            </div>
            
            <nav className="flex flex-col gap-2">
              <a href="/dashboard" className="px-4 py-2.5 rounded bg-[#f8b800]/10 border border-[#f8b800] text-white font-medium text-sm flex items-center gap-3 transition">
                <span className="w-1.5 h-1.5 rounded-full bg-[#f8b800]"></span>
                Dashboard
              </a>
              <a href="#" className="px-4 py-2.5 rounded text-zinc-400 hover:text-white hover:bg-zinc-900 font-medium text-sm flex items-center gap-3 transition">
                <span className="w-1.5 h-1.5 rounded-full bg-transparent"></span>
                Clients
              </a>
              <a href="#" className="px-4 py-2.5 rounded text-zinc-400 hover:text-white hover:bg-zinc-900 font-medium text-sm flex items-center gap-3 transition">
                <span className="w-1.5 h-1.5 rounded-full bg-transparent"></span>
                Advisory State
              </a>
            </nav>
          </div>

          <div className="pt-4 border-t border-zinc-800 text-[11px] text-zinc-500">
            System status: <span className="text-emerald-400 font-semibold">APEX ACTIVE</span>
          </div>
        </aside>

        {/* Main Content Area */}
        <main className="flex-1 flex flex-col overflow-y-auto bg-[#f0f0f0]">
          {/* Top Bar */}
          <header className="h-16 border-b border-zinc-200 bg-white flex items-center justify-between px-8 shrink-0">
            <div className="font-semibold text-zinc-800 text-sm">Strategic Workspace Dashboard</div>
            <div className="flex items-center gap-4 text-xs text-zinc-500">
              User: <span className="font-semibold text-black">Jeremy Bensen</span>
              <div className="w-2 h-2 rounded-full bg-[#f8b800]"></div>
            </div>
          </header>

          <div className="flex-1 p-8">
            {children}
          </div>
        </main>
      </body>
    </html>
  );
}
