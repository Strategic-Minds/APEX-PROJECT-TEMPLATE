# APEX Project Setup Guide

## How to Start a New Project in 5 Minutes

### Step 1 — Run Init Script
```bash
export VERCEL_TOKEN="..."
export SUPABASE_SERVICE_ROLE_KEY="..."
chmod +x scripts/init-project.sh
./scripts/init-project.sh "Project Name" "revenue_channel" "template_id"
```
This creates: GitHub repo + Vercel project + Supabase registration.

### Step 2 — Add Approved Mockups to Drive
Upload your approved PNG mockups to Drive: 01-SPECS folder.
These become the controlling visual contract.

### Step 3 — Generate Memory Files
```bash
export SUPABASE_SERVICE_ROLE_KEY="..."
python3 scripts/generate-memory.py "Project Name"
```
This outputs:
- ProjectName_GPT_MEMORY.md — paste into ChatGPT at session start
- ProjectName_APEX_MEMORY.md — paste into Base44 memory.md

### Step 4 — Submit to UACS Queue
POST to missionRouter:
```json
{
  "mission_title": "Project Name",
  "mission_type": "autonomous_build",
  "priority": "P1",
  "source_repo": "Strategic-Minds/repo-name",
  "requirements": ["visual_parity_99pct", "faang_gate_90"],
  "template_id": "tmpl-epoxy-estimator"
}
```

### Step 5 — Watch It Build
- GitHub Actions runs FAANG QA gate on every push
- BrowserWorker validates screenshots vs 01-SPECS mockups
- Drive syncs daily at 9am EST + on every push
- Supabase tracks all scores and receipts

## Revenue Channel → Template Map
| Channel | Template ID | $1M Path |
|---------|-------------|----------|
| Epoxy city site | tmpl-city-epoxy-site | 7 cities × $60K = $420K |
| Contractor estimator | tmpl-epoxy-estimator | PCU alumni upsell + demo tool |
| Consulting dashboard | tmpl-consulting-dashboard | 20 clients × $60K = $1.2M |
| Contractor app | tmpl-contractor-app | ServiceTitan alternative |

## Bidirectional Sync Flow
Drive (01-SPECS mockups) → APEX reads → GitHub push → Vercel auto-deploy
ChatGPT brand → Drive (02-BRAND-CHATGPT) → GitHub → build
BrowserWorker validates → score to Supabase uacs_qa_results + Drive 04-QA-REPORTS
APEX daily: reads Drive 09-SYNC-STATE, updates memory.md
