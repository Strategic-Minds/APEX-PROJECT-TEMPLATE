-- Strategic Minds APEX Seed Template
-- Table structure for clients, projects, and KPIs

CREATE TABLE IF NOT EXISTS clients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE TABLE IF NOT EXISTS projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    status TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

CREATE TABLE IF NOT EXISTS kpis (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    metric_name TEXT NOT NULL,
    metric_value TEXT NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Placeholder seed data
INSERT INTO clients (id, name) VALUES 
('00000000-0000-0000-0000-000000000001', 'Strategic Minds Advisory')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO projects (id, client_id, name, status) VALUES 
('00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'APEX OS Deployment', 'Active')
ON CONFLICT (id) DO UPDATE SET status = EXCLUDED.status;

INSERT INTO kpis (id, project_id, metric_name, metric_value) VALUES 
('00000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000002', 'APEX System Integration', '100%'),
('00000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000002', 'Active Clients Tracked', '12'),
('00000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000002', 'Sync Health Rate', '99.8%')
ON CONFLICT (id) DO UPDATE SET metric_value = EXCLUDED.metric_value;
