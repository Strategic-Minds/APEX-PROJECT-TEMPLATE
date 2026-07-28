# Strategic Minds APEX Setup Guide

Follow this guide to boot a new project workspace based on the APEX platform.

## Prerequisites
Ensure you have the following environments configured or API keys available:
1. **GitHub Access**: Organization administrator access to `Strategic-Minds`.
2. **Google Drive Credentials**: Refresh token or access token mapped with access to folders.
3. **Vercel Account**: Authorized to provision Next.js 14 deployments.
4. **Supabase Project**: An active DB reference URL with PostgreSQL capability.

## Project Bootstrapping Sequence

Run the quickstart CLI helper script from your terminal:

```bash
chmod +x scripts/init-project.sh
./scripts/init-project.sh "My-New-Project" "Client-Name"
```

The CLI script automates:
1. **Folder Provisions**: Sets up a Google Drive container under `09-SYNC-STATE`.
2. **Repository Clones**: Duplicates this master template into a client-specific repository.
3. **Infrastructure Setup**: Deploys project boundaries to Vercel and provisions database schemas on Supabase.

## Environment Secrets Setup

Add these secrets to your GitHub repository Settings (`https://github.com/Strategic-Minds/<repo-name>/settings/secrets/actions`):

| Secret Name | Purpose |
| :--- | :--- |
| `GOOGLEDRIVE_ACCESS_TOKEN` | Auth token for state replication to Drive |
| `BROWSERWORKER_SECRET` | Header-based token authorizing screenshot tests |
| `BROWSERWORKER_URL` | Endpoint of the automated visual checker |
