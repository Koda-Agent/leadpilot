# Setup Instructions for Aaryush

## What's Been Completed (Automated)

✅ Next.js project initialized with TypeScript and Tailwind CSS
✅ Static export configured for GitHub Pages (basePath: /leadpilot)
✅ Shadcn/ui components installed and configured
✅ Supabase client code created
✅ GitHub Actions deployment workflow created
✅ Initial commit made locally

## Manual Steps Required (Need Your Action)

### 1. Create Supabase Project (10 minutes)

1. Go to https://supabase.com/dashboard
2. Click "New Project"
3. Name: `leadpilot`
4. Database Password: (generate a strong password, save it)
5. Region: Choose closest to you
6. Click "Create new project" (wait ~2 minutes for provisioning)

Once created:
7. Go to Project Settings > API
8. Copy the "Project URL" (starts with https://...)
9. Copy the "anon public" key (starts with eyJ...)
10. Update `/home/ubuntu/.openclaw/workspace/leadpilot/.env.local`:
    ```
    NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
    NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
    ```

11. Go to SQL Editor
12. Copy the contents of `docs/supabase-schema.sql`
13. Paste and click "Run"
14. Verify the `waitlist` table was created (check Table Editor)

### 2. Create GitHub Repository (5 minutes)

Option A: Using GitHub.com (web)
1. Go to https://github.com/new
2. Repository name: `leadpilot`
3. Owner: `koda-agent299`
4. Visibility: Public
5. Do NOT initialize with README (we already have one)
6. Click "Create repository"

Option B: Using GitHub CLI (if installed)
```bash
cd /home/ubuntu/.openclaw/workspace/leadpilot
gh repo create koda-agent299/leadpilot --public --source=. --push
```

### 3. Push to GitHub (if using web method)

```bash
cd /home/ubuntu/.openclaw/workspace/leadpilot
git push -u origin main
```

If prompted for credentials:
- Use GitHub Personal Access Token (not password)
- Generate one at: https://github.com/settings/tokens
- Select scopes: `repo` (full control of private repositories)

### 4. Enable GitHub Pages

1. Go to repository: https://github.com/koda-agent299/leadpilot
2. Click Settings > Pages (left sidebar)
3. Source: **GitHub Actions** (not "Deploy from a branch")
4. Save

The first deployment will trigger automatically after pushing to main.

### 5. Verify Deployment (after ~2-3 minutes)

1. Go to Actions tab: https://github.com/koda-agent299/leadpilot/actions
2. Check the "Deploy to GitHub Pages" workflow
3. Once complete (green checkmark), visit:
   - https://koda-agent299.github.io/leadpilot/

## Environment Variables

The `.env.local` file is gitignored (not pushed to GitHub). This is correct - sensitive keys stay local.

For production (GitHub Pages), environment variables aren't needed because:
- The site is static (no server-side code)
- Form submission will use Supabase directly from the browser
- The anon key is safe to expose (it's in the built JavaScript)

## Next Steps

Once the above is complete:
1. Confirm the site loads at the GitHub Pages URL
2. Agent 2 will build the landing page content
3. Agent 3 will build the waitlist form

## Verification Checklist

- [ ] Supabase project created
- [ ] `waitlist` table exists in Supabase
- [ ] `.env.local` updated with real credentials
- [ ] GitHub repository created
- [ ] Code pushed to GitHub
- [ ] GitHub Pages enabled (source: GitHub Actions)
- [ ] Site accessible at https://koda-agent299.github.io/leadpilot/

## Troubleshooting

**If build fails on GitHub Actions:**
- Check the Actions log for errors
- Most common: missing dependencies (should be fixed by npm ci)

**If site shows 404:**
- Verify GitHub Pages is enabled
- Check source is set to "GitHub Actions" not "branch"
- Wait 2-3 minutes for deployment to complete

**If site looks broken:**
- Check browser console for 404s
- Verify basePath is correct in next.config.ts

## Contact

Questions? Reply to koda-agent299@agentmail.to
