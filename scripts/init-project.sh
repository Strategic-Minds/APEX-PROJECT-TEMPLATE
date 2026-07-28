#!/usr/bin/env bash
# APEX Project Init Script
# Usage: ./scripts/init-project.sh "My Project Name" "revenue_channel" "template_id"
# Example: ./scripts/init-project.sh "Phoenix Epoxy Pros Denver" "epoxy" "tmpl-epoxy-estimator"

set -e

PROJECT_NAME="${1:?Error: PROJECT_NAME required}"
REVENUE_CHANNEL="${2:-consulting}"
TEMPLATE_ID="${3:-tmpl-epoxy-estimator}"
SLUG=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')

echo "========================================"
echo "  APEX PROJECT INIT — $PROJECT_NAME"
echo "========================================"

GH_ORG="Strategic-Minds"
REPO_NAME="${SLUG}"
VERCEL_TEAM="team_aFdds8lsbHMwe2ip4aQdbQ3d"
SB_REF="prhppuuwcnmfdhwsagug"
SB_URL="https://prhppuuwcnmfdhwsagug.supabase.co"

echo ""
echo "[1/5] Creating GitHub repo from template..."
gh repo create "${GH_ORG}/${REPO_NAME}" \
  --private \
  --template "${GH_ORG}/APEX-PROJECT-TEMPLATE" \
  --description "APEX managed project: $PROJECT_NAME" 2>/dev/null || echo "  Repo may already exist"
echo "  GitHub: https://github.com/${GH_ORG}/${REPO_NAME}"

echo ""
echo "[2/5] Creating Vercel project..."
VERCEL_RESPONSE=$(curl -s -X POST "https://api.vercel.com/v10/projects?teamId=${VERCEL_TEAM}" \
  -H "Authorization: Bearer ${VERCEL_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"${SLUG}\",\"framework\":\"nextjs\",\"gitRepository\":{\"type\":\"github\",\"repo\":\"${GH_ORG}/${REPO_NAME}\"}}")
VERCEL_ID=$(echo "$VERCEL_RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('id',''))" 2>/dev/null)
VERCEL_URL="https://${SLUG}.vercel.app"
echo "  Vercel project: ${VERCEL_ID}"
echo "  Vercel URL: ${VERCEL_URL}"

echo ""
echo "[3/5] Registering in Supabase..."
curl -s -X POST "${SB_URL}/rest/v1/rpc/apex_init_project" \
  -H "Authorization: Bearer ${SUPABASE_SERVICE_ROLE_KEY}" \
  -H "apikey: ${SUPABASE_SERVICE_ROLE_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"p_name\":\"${PROJECT_NAME}\",\"p_client\":\"${PROJECT_NAME}\",\"p_revenue_channel\":\"${REVENUE_CHANNEL}\",\"p_github_repo\":\"${GH_ORG}/${REPO_NAME}\",\"p_vercel_url\":\"${VERCEL_URL}\",\"p_drive_folder_id\":\"\",\"p_template_id\":\"${TEMPLATE_ID}\"}" > /dev/null
echo "  Registered in apex_project_registry"

echo ""
echo "[4/5] Generating memory files..."
python3 scripts/generate-memory.py "${PROJECT_NAME}" 2>/dev/null || echo "  Run manually: python3 scripts/generate-memory.py \"${PROJECT_NAME}\""

echo ""
echo "[5/5] Setting Vercel environment variables..."
for KEY in NEXT_PUBLIC_SUPABASE_URL NEXT_PUBLIC_SUPABASE_ANON_KEY SUPABASE_SERVICE_ROLE_KEY; do
  VAL="${!KEY}"
  if [ -n "$VAL" ] && [ -n "$VERCEL_ID" ]; then
    curl -s -X POST "https://api.vercel.com/v10/projects/${VERCEL_ID}/env?teamId=${VERCEL_TEAM}" \
      -H "Authorization: Bearer ${VERCEL_TOKEN}" \
      -H "Content-Type: application/json" \
      -d "{\"key\":\"${KEY}\",\"value\":\"${VAL}\",\"type\":\"encrypted\",\"target\":[\"production\",\"preview\",\"development\"]}" > /dev/null
  fi
done
echo "  Supabase env vars injected"

echo ""
echo "========================================"
echo "  INIT COMPLETE"
echo "========================================"
echo "  GitHub:   https://github.com/${GH_ORG}/${REPO_NAME}"
echo "  Vercel:   ${VERCEL_URL}"
echo "  Supabase: ${SB_URL}"
echo ""
echo "NEXT STEPS:"
echo "  1. Add approved mockups to Drive 01-SPECS"
echo "  2. Run: python3 scripts/generate-memory.py \"${PROJECT_NAME}\""
echo "  3. Submit to UACS queue via missionRouter"
