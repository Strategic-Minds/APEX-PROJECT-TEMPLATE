# APEX Bidirectional State Synchronization System

This document details the architectural data highways that APEX uses to keep Google Drive, GitHub, Vercel, Supabase, and OpenAI in absolute sync.

## Sync Architecture Flow

```
                      ┌──────────────────────┐
                      │  Google Drive Folder │
                      │   (09-SYNC-STATE)    │
                      └──────────▲───────────┘
                                 │
                   sync-state.py │ (Pull/Push)
                                 │
                      ┌──────────▼───────────┐
                      │  GitHub Repository   │  Auto-deploy
                      │ (template.config.json) ├──────────────┐
                      └──────────▲───────────┘              │
                                 │                          ▼
                PR Gates         │                     ┌──────────┐
           (faang-qa-gate.yml)   │                     │  Vercel  │
                                 │                     │  Engine  │
                      ┌──────────┴───────────┐         └────┬─────┘
                      │  Developer / Agent   │              │ Environment
                      │      Workspace       │              │ Variables
                      └──────────────────────┘              ▼
                                                       ┌──────────┐
                                                       │ Supabase │
                                                       │ Database │
                                                       └──────────┘
```

## Detailed Synchronization Pathways

### 1. Google Drive <-> GitHub (Actions Integration)
*   **Mechanism**: A Python agent script (`scripts/sync-state.py`) reads the master project JSON config (`template.config.json`) and exports state dumps directly to the client's `09-SYNC-STATE` folder on Google Drive.
*   **Triggers**: On every Git push to the `main` branch, a GitHub Action (`drive-sync.yml`) wakes up, loads the `GOOGLEDRIVE_ACCESS_TOKEN`, and synchronizes state metrics.

### 2. GitHub -> Vercel (CI/CD Deployment)
*   **Mechanism**: Vercel integrates natively with the GitHub project. Every merge to `main` starts a production deployment immediately.
*   **Post-Deploy validation**: Once the deploy finishes successfully, the `browserworker-validate.yml` workflow fires off a signal to **BrowserWorker** to capture visual UI screenshots, ensuring zero design-system drift.

### 3. Vercel <-> Supabase (State Bridge)
*   **Mechanism**: Serverless APIs inside Next.js use credentials defined in Vercel's environment variables to securely execute mutations or read data from the Supabase instance.
