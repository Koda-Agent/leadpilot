-- LeadPilot Waitlist Table Schema
-- Run this in Supabase SQL Editor

CREATE TABLE waitlist (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  business_name TEXT NOT NULL,
  phone TEXT,
  message TEXT,
  source TEXT DEFAULT 'landing_page',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  contacted BOOLEAN DEFAULT FALSE,
  contacted_at TIMESTAMPTZ
);

-- Indexes for performance
CREATE INDEX idx_waitlist_email ON waitlist(email);
CREATE INDEX idx_waitlist_created_at ON waitlist(created_at DESC);

-- Enable Row Level Security
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- Policy: Allow public inserts (for form submissions)
CREATE POLICY "Allow public inserts"
ON waitlist FOR INSERT
TO anon
WITH CHECK (true);

-- Policy: Allow public reads for own email (future: for "already registered" check)
CREATE POLICY "Allow public reads for own email"
ON waitlist FOR SELECT
TO anon
USING (email = current_setting('request.jwt.claims', true)::json->>'email');
