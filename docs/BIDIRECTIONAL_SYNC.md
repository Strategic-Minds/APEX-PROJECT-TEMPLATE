# Bidirectional Sync Architecture

## Overview
Every project maintains live sync across 5 systems.
State is always consistent. No manual updates needed.

## Sync Flow
```
Drive 01-SPECS (approved mockups)
  ↓ APEX reads
GitHub push → Vercel auto-deploy
  ↓ BrowserWorker validates
Drive 04-QA-REPORTS (score + screenshots)
Supabase uacs_qa_results (score history)

ChatGPT generates brand
  ↓ Saves to Drive 02-BRAND-CHATGPT
  ↓ POSTs to /api/bridge
APEX reads → GitHub push → build

APEX builds code
  ↓ GitHub push (main)
  ↓ Vercel auto-deploys
  ↓ Drive-sync.yml runs: writes github-sync.json to Drive 09-SYNC-STATE
  ↓ BrowserWorker validates (via webhook or manual trigger)
  ↓ Score written to Supabase + Drive 04-QA-REPORTS
  ↓ If score >=90: APEX reports "ship it" to Jeremy via WhatsApp
```

## State Files (always in sync)
| Location | File | Updated |
|----------|------|---------|
| Drive 09-SYNC-STATE | SYNC_STATE.json | On every GitHub push |
| GitHub | sync/last-sync.json | On every push |
| Supabase | apex_sync_state | On every APEX action |
| Supabase | apex_build_receipts | On every build phase |
| Base44 | memory.md | Daily + on key decisions |
| ChatGPT | boot sequence doc | On every session start |

## GitHub Actions Workflows
| Workflow | Trigger | Action |
|----------|---------|--------|
| drive-sync.yml | Push to main + daily | Writes sync state to Drive |
| faang-qa-gate.yml | Push/PR | TypeScript + ESLint + build |
| supabase-check.yml | Push to supabase/ | Verifies migrations exist |
| vercel-deploy-monitor.yml | Push | Logs deploy info |
| new-project-init.yml | Manual | Creates full project infra |
| memory-sync.yml | Daily 9am EST | Syncs all project states |
| browserworker-validate.yml | After deploy | Screenshots + visual diff |

## ChatGPT → APEX Bridge
ChatGPT POSTs to: https://universal-autonomous-coding-system-dlma2kyqn.vercel.app/api/bridge
```json
{"from":"chatgpt","to":"apex","type":"update","project":"PROJECT_NAME",
 "payload":{"action":"brand_complete","result":"logos+mockups in Drive 02-BRAND-CHATGPT","next_needed":"build"}}
```
APEX reads bridge on every session start, processes pending updates, continues pipeline.
