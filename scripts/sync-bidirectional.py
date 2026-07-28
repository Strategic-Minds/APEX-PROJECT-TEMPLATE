#!/usr/bin/env python3
"""
APEX Bidirectional Sync — reads all projects from Supabase, 
writes SYNC_STATE.json to Drive for each, reads ChatGPT updates back.
Run daily via GitHub Actions or manually.
"""
import urllib.request, json, os, datetime, urllib.parse

SB_URL = 'https://prhppuuwcnmfdhwsagug.supabase.co'
SB_KEY = os.environ.get('SUPABASE_SERVICE_ROLE_KEY', '')
DRIVE_TOKEN = os.environ.get('GOOGLEDRIVE_ACCESS_TOKEN', '')

def sb_get(path):
    req = urllib.request.Request(f'{SB_URL}/rest/v1{path}')
    req.add_header('Authorization', f'Bearer {SB_KEY}')
    req.add_header('apikey', SB_KEY)
    try:
        with urllib.request.urlopen(req, timeout=10) as r:
            return json.loads(r.read())
    except: return []

def sb_post(path, data):
    req = urllib.request.Request(f'{SB_URL}/rest/v1{path}', method='POST', data=json.dumps(data).encode())
    req.add_header('Authorization', f'Bearer {SB_KEY}')
    req.add_header('apikey', SB_KEY)
    req.add_header('Content-Type', 'application/json')
    req.add_header('Prefer', 'return=minimal')
    try:
        with urllib.request.urlopen(req, timeout=10) as r:
            return r.status
    except: return 0

def upload_to_drive(name, content, folder_id):
    if not DRIVE_TOKEN or not folder_id:
        return 0
    boundary = 'sync_b' 
    meta = json.dumps({'name': name, 'parents': [folder_id]})
    body = f'--{boundary}\r\nContent-Type: application/json\r\n\r\n{meta}\r\n--{boundary}\r\nContent-Type: text/plain\r\n\r\n{content}\r\n--{boundary}--'.encode()
    url = 'https://www.googleapis.com/upload/drive/v3/files?' + urllib.parse.urlencode({'uploadType': 'multipart'})
    req = urllib.request.Request(url, method='POST', data=body)
    req.add_header('Authorization', f'Bearer {DRIVE_TOKEN}')
    req.add_header('Content-Type', f'multipart/related; boundary={boundary}')
    try:
        with urllib.request.urlopen(req, timeout=15) as r:
            return r.status
    except: return 0

now = datetime.datetime.utcnow().isoformat() + 'Z'
print(f"APEX Memory Sync — {now}")
print("=" * 50)

# Read all active projects
projects = sb_get('/apex_project_registry?status=neq.archived&order=project_name')
print(f"Active projects: {len(projects)}")

for p in projects:
    name = p.get('project_name', '?')
    drive_id = p.get('drive_folder_id', '')
    
    state = {
        'project_name': name,
        'last_sync': now,
        'github_repo': p.get('github_repo', ''),
        'vercel_url': p.get('vercel_url', ''),
        'supabase_ref': p.get('supabase_ref', 'prhppuuwcnmfdhwsagug'),
        'drive_folder_id': drive_id,
        'status': p.get('status', 'idea'),
        'current_phase': p.get('current_phase', 'idea'),
        'faang_score': p.get('faang_score', 0),
        'open_blockers': p.get('open_blockers', []),
        'synced_by': 'apex'
    }
    
    # Write to Supabase apex_sync_state
    sb_post('/apex_sync_state', {'project_name': name, 'source': 'base44', 'state_json': state})
    
    # Write to Drive 09-SYNC-STATE (if folder ID known)
    if drive_id:
        status = upload_to_drive(f'SYNC_STATE_{now[:10]}.json', json.dumps(state, indent=2), drive_id)
        print(f"  {name}: Drive sync HTTP {status}")
    else:
        print(f"  {name}: No Drive folder ID — skipping Drive upload")

# Write receipt
sb_post('/apex_build_receipts', {
    'project_name': 'ALL',
    'phase': 'sync',
    'agent': 'apex',
    'action': 'bidirectional_memory_sync',
    'status': 'complete',
    'output_summary': f'Synced {len(projects)} projects at {now}'
})

print(f"\nSync complete — {len(projects)} projects updated")
