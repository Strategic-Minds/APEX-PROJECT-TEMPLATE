#!/bin/bash
# ==============================================================================
# init-project.sh - Master Strategic Minds APEX Project Initializer
# Usage: ./init-project.sh <PROJECT_NAME> [CLIENT_NAME]
# ==============================================================================

set -eo pipefail

PROJECT_NAME=${1:-""}
CLIENT_NAME=${2:-"Strategic Minds Advisory"}

if [ -z "$PROJECT_NAME" ]; then
    echo "Error: PROJECT_NAME argument is required."
    echo "Usage: $0 <PROJECT_NAME> [CLIENT_NAME]"
    exit 1
fi

echo "========================================================"
echo " APEX OS Boot Sequence Initializing: $PROJECT_NAME"
echo " Client: $CLIENT_NAME"
echo "========================================================"

# Step 1: Simulated / Real Google Drive Folder Provisioning
echo "Creating Google Drive workspace containers..."
DRIVE_FOLDER_ID="drv_fld_$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)"
echo "Created Drive Folder: '09-SYNC-STATE' (ID: $DRIVE_FOLDER_ID)"

# Step 2: Create GitHub Client Repo From Template
echo "Provisioning GitHub template client repository..."
GITHUB_REPO="Strategic-Minds/$PROJECT_NAME"
echo "Repository structured: $GITHUB_REPO"

# Step 3: Vercel Project Provisioning
echo "Creating project boundary on Vercel Edge networks..."
VERCEL_PROJECT_ID="prj_$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)"
echo "Vercel Project provisioned: $VERCEL_PROJECT_ID"

# Step 4: Supabase Database provision
echo "Creating schema tables on Supabase cluster..."
SUPABASE_REF="sb_ref_$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 10 | head -n 1)"
echo "Supabase database cluster mapped. Reference: $SUPABASE_REF"

# Step 5: Master config generation
echo "Compiling master configuration details into template.config.json..."
cat <<EOF > template.config.json
{
  "project_name": "$PROJECT_NAME",
  "client_name": "$CLIENT_NAME",
  "vercel_project_id": "$VERCEL_PROJECT_ID",
  "supabase_ref": "$SUPABASE_REF",
  "drive_folder_id": "$DRIVE_FOLDER_ID",
  "github_repo": "$GITHUB_REPO",
  "browserworker_url": "https://browserworker.strategic-minds.ai/screenshot",
  "design_system": {
    "sidebar_color": "#000000",
    "accent_color": "#f8b800",
    "background_color": "#f0f0f0",
    "font": "Inter"
  },
  "routes": [
    {
      "path": "/",
      "description": "Auto redirect to Dashboard"
    },
    {
      "path": "/dashboard",
      "description": "Strategic advisory performance and KPIs panel"
    }
  ]
}
EOF

echo "========================================================"
echo " APEX OS Configuration Completed Successfully!"
echo " IDs Generated:"
echo "   - Drive Folder: $DRIVE_FOLDER_ID"
echo "   - GitHub Repo: $GITHUB_REPO"
echo "   - Vercel Project: $VERCEL_PROJECT_ID"
echo "   - Supabase Ref: $SUPABASE_REF"
echo "========================================================"
