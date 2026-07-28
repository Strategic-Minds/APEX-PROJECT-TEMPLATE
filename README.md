# APEX Project Template

Welcome to the **APEX Project Template** — the master GitHub project repository structure designed for **Strategic Minds Advisory**. APEX operates as the advanced AI OS for managing advisory client delivery, bidirectional synchronization, automated validation gates, and seamless multi-platform deployments.

## Architecture & Ecosystem

```
         ┌───────────────────────────────────────┐
         │       Google Drive Document           │
         │   Strategic Advisory Working Docs     │
         └──────────────────┬────────────────────┘
                            │ Bidirectional Sync
                            ▼ (via sync-state.py)
         ┌───────────────────────────────────────┐
         │       GitHub Project Repo             │
         │   (Automation, Code & State)          │
         └──────────────────┬────────────────────┘
                            │ Auto-Deployment
                            ▼
         ┌───────────────────────────────────────┐
         │       Vercel Serverless App           │
         │  (KPI Dashboards & Agent Bridge API)   │
         └──────────────────┬────────────────────┘
                            │ Real-time DB & Auth
                            ▼
         ┌───────────────────────────────────────┐
         │         Supabase Database             │
         │       Clients, KPIs & State           │
         └───────────────────────────────────────┘
```

This template sets up a unified system integrating:
1. **Google Drive Sync**: Automatic, bidirectional sync keeping client documents in sync with GitHub state using a robust state manager.
2. **Next.js & Tailwind App**: A highly polished advisory frontend respecting the **Strategic Minds Design Law** (Black sidebar, gold accent, clean grid layout).
3. **Supabase Integration**: Standardized migrations, seed schema for KPIs, clients, and projects, enabling real-time status updates.
4. **CI/CD Quality Gates**: Strict FAANG-grade verification rules (ESLint, TypeScript strictness, Next.js build verification, BrowserWorker automated visual testing, Supabase migration safety).

## Template Directory Structure

```text
.
├── .github/
│   └── workflows/
│       ├── drive-sync.yml              # Syncs project state to Google Drive on push
│       ├── faang-qa-gate.yml           # Strict TS + ESLint + Next.js build gate
│       ├── supabase-check.yml          # Verifies migrations exist on Supabase folder push
│       ├── vercel-deploy-monitor.yml   # Logs and tracks Vercel deployment events
│       └── browserworker-validate.yml  # Visual screenshot check post-deployment
├── app/
│   ├── dashboard/
│   │   └── page.tsx                    # Client-facing KPI and advisory metrics view
│   ├── layout.tsx                      # Strict Strategic Minds core layout
│   └── page.tsx                        # Redirects users seamlessly to dashboard
├── docs/
│   ├── AGENT_MEMORY_BASE44.md          # APEX/Base44 agent context template
│   ├── AGENT_MEMORY_GPT.md             # ChatGPT / Custom GPT context bootstrap
│   ├── BIDIRECTIONAL_SYNC.md           # Explanation of state/data sync pathways
│   ├── DESIGN_SYSTEM.md                # Strategic Minds design & interface law
│   └── SETUP.md                        # Step-by-step project boot setup
├── scripts/
│   ├── init-project.sh                 # Zero-touch automation setup for new engagements
│   └── sync-state.py                   # State push/pull daemon for Drive sync
├── supabase/
│   ├── migrations/
│   │   └── .gitkeep                    # Directory anchor for DB migrations
│   └── seed.sql                        # Base SQL seed schema and records
├── next.config.js                      # Config with security & CORS headers
├── package.json                        # Strictly versioned workspace dependencies
├── tailwind.config.ts                  # Integrated design tokens & theme setup
├── template.config.json                # Master project configuration file
└── tsconfig.json                       # FAANG-standard TypeScript strict settings
```

## Quick Start

Initialize your next project engagement with a single command:
```bash
./scripts/init-project.sh "Client-Name"
```

Refer to [docs/SETUP.md](docs/SETUP.md) for full environmental configuration instructions.
