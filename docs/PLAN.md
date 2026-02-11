# LeadPilot - Execution Plan

## Timeline: 6 Hours Total

---

## Phase 1: Project Setup (30 minutes)

### Objectives
- Initialize Next.js project with proper configuration
- Set up Supabase project and database
- Configure GitHub repository
- Establish development workflow

### Tasks
1. **Create Next.js project** (10 min)
   - `npx create-next-app@latest` with TypeScript, Tailwind, App Router
   - Configure `next.config.js` for static export
   - Install Shadcn/ui and initialize components
   - Set up project structure (components, lib, types)

2. **Initialize Supabase** (10 min)
   - Create new Supabase project (free tier)
   - Create `waitlist` table with schema from SPEC.md
   - Set up RLS policies (allow public inserts only)
   - Generate anon key and store in `.env.local`

3. **GitHub repository setup** (10 min)
   - Create repo: `koda-agent299/leadpilot`
   - Push initial commit
   - Set up GitHub Pages (gh-pages branch)
   - Configure GitHub Actions deploy workflow

### Deliverables
- ✅ Working Next.js project with static export
- ✅ Supabase project with database schema
- ✅ GitHub repo with auto-deploy pipeline
- ✅ Development environment ready

### Acceptance Criteria
- `npm run dev` starts local server
- `npm run build` generates static export
- GitHub Actions workflow deploys to Pages
- Supabase connection works (can insert test record)

---

## Phase 2: Landing Page (2 hours)

### Objectives
- Build professional, conversion-focused landing page
- Implement hero, features, how-it-works, pricing sections
- Ensure mobile responsiveness
- Optimize for fast loading

### Tasks
1. **Hero Section** (30 min)
   - Headline + subheadline copy
   - Primary CTA button ("Request Early Access")
   - Secondary CTA (scroll to features)
   - Hero image/illustration placeholder
   - Responsive layout (mobile, tablet, desktop)

2. **How It Works Section** (20 min)
   - 3-step process with icons
   - Clear, benefit-focused copy
   - Visual flow (step 1 → 2 → 3)

3. **Features Section** (30 min)
   - 6 feature cards with icons
   - Short description for each
   - Grid layout (responsive: 1 col mobile, 2 col tablet, 3 col desktop)

4. **Pricing Section** (20 min)
   - 3 pricing tiers (Starter, Pro, Enterprise)
   - Feature comparison
   - "Early access 50% off" badge
   - CTA buttons for each tier

5. **Social Proof Section** (10 min)
   - 3 placeholder testimonials
   - "Trusted by..." text
   - Logo placeholders

6. **Footer** (10 min)
   - Logo, links, copyright
   - Responsive layout

### Deliverables
- ✅ Complete landing page (`/`)
- ✅ Mobile responsive (works on 375px width)
- ✅ All CTAs point to `/access`

### Acceptance Criteria
- Page loads in <2 seconds
- All sections render correctly
- Mobile layout doesn't break
- CTAs are clearly visible
- Copy matches SPEC.md

---

## Phase 3: Request Access Form (1 hour)

### Objectives
- Build functional form with validation
- Connect to Supabase for data storage
- Implement confirmation flow
- Send confirmation email via Agentmail

### Tasks
1. **Form UI** (20 min)
   - Form fields: name, email, business, phone, message
   - Client-side validation (required fields, email format)
   - Error states and messages
   - Submit button with loading state

2. **Supabase Integration** (20 min)
   - Create Supabase client in `lib/supabase.ts`
   - Form submit handler (server action or API route)
   - Insert record into `waitlist` table
   - Handle success/error states

3. **Thank You Page** (10 min)
   - Success message
   - Next steps copy
   - CTA back to home

4. **Confirmation Email** (10 min)
   - Agentmail send function
   - Email template from SPEC.md
   - Trigger on form submission
   - Error handling (silent fail if email fails)

### Deliverables
- ✅ Working form at `/access`
- ✅ Form submissions save to Supabase
- ✅ Thank you page at `/thank-you`
- ✅ Confirmation email sent

### Acceptance Criteria
- Form validates before submit
- Duplicate emails show friendly error
- Submission redirects to thank-you page
- Supabase table receives record
- Confirmation email arrives within 60 seconds

---

## Phase 4: Product Shell (1.5 hours)

### Objectives
- Create locked dashboard to show product is real
- Design dashboard mockup
- Add visual credibility to the product

### Tasks
1. **Dashboard Shell Page** (30 min)
   - Header with logo
   - "Early Access Only" message
   - CTA to request access
   - Mockup screenshot of future dashboard

2. **Dashboard Mockup Design** (45 min)
   - Inquiry table mockup (fake data)
   - Header with stats (total inquiries, response time)
   - Sidebar navigation (locked)
   - Settings icon (locked)
   - Make it look like a real product screenshot

3. **Navigation** (15 min)
   - Add header nav to all pages
   - Logo links to home
   - "Dashboard" link (goes to locked page)
   - "Request Access" button in nav

### Deliverables
- ✅ Dashboard shell at `/dashboard`
- ✅ Dashboard mockup image
- ✅ Site-wide navigation

### Acceptance Criteria
- Dashboard page exists and looks professional
- Mockup shows realistic product UI
- Navigation works across all pages
- Clear that dashboard is locked (not a bug)

---

## Phase 5: Polish & Deploy (1 hour)

### Objectives
- Fix any UI issues
- Optimize for mobile
- Test all flows
- Deploy to GitHub Pages

### Tasks
1. **Mobile Testing** (20 min)
   - Test all pages at 375px, 768px, 1024px widths
   - Fix any layout breaks
   - Ensure buttons are tappable (min 44px)
   - Check font sizes (min 16px for inputs)

2. **Performance Optimization** (15 min)
   - Optimize images (compress, proper formats)
   - Check bundle size
   - Lazy load images below fold
   - Ensure fast static export

3. **Final Testing** (15 min)
   - Test form submission end-to-end
   - Verify Supabase insert
   - Check confirmation email
   - Test all navigation links
   - Proofread copy

4. **Deploy** (10 min)
   - Push to GitHub main branch
   - Verify GitHub Actions deploy succeeds
   - Test live site on GitHub Pages
   - Check site works on mobile device

### Deliverables
- ✅ All pages mobile responsive
- ✅ Site live on GitHub Pages
- ✅ All flows tested and working
- ✅ Fast load times (<2s)

### Acceptance Criteria
- Site accessible at `https://koda-agent299.github.io/leadpilot/`
- All pages load correctly
- Form submissions work
- Mobile experience is smooth
- No console errors

---

## Sub-Agent Assignments

### Agent 1: Setup & Infrastructure
**Responsibility:** Phase 1
**Deliverables:** Next.js project, Supabase, GitHub repo
**Estimated Time:** 30 minutes

### Agent 2: Landing Page
**Responsibility:** Phase 2
**Deliverables:** Complete landing page with all sections
**Estimated Time:** 2 hours

### Agent 3: Form & Data Flow
**Responsibility:** Phase 3
**Deliverables:** Request access form, Supabase integration, confirmation email
**Estimated Time:** 1 hour

### Agent 4: Product Shell & Mockups
**Responsibility:** Phase 4
**Deliverables:** Dashboard shell, mockup design, navigation
**Estimated Time:** 1.5 hours

### Agent 5: Polish & Deploy
**Responsibility:** Phase 5
**Deliverables:** Mobile optimization, testing, deployment
**Estimated Time:** 1 hour

---

## Coordination & Handoffs

### Phase 1 → Phase 2
- Agent 1 completes setup
- Commits to main branch
- Agent 2 pulls latest, starts landing page work

### Phase 2 → Phase 3
- Agent 2 completes landing page
- Commits all components to `components/landing/`
- Agent 3 pulls latest, builds form

### Phase 3 → Phase 4
- Agent 3 completes form integration
- Tests Supabase connection
- Agent 4 pulls latest, builds dashboard shell

### Phase 4 → Phase 5
- Agent 4 completes product shell
- All pages exist and linked
- Agent 5 pulls latest, polishes and deploys

---

## Communication Protocol

### Progress Updates
Each agent reports:
- Start of phase (what they're working on)
- Blockers (if any)
- Completion (what was delivered)

### Format
```
PHASE [N] START: [Phase Name]
- Task 1: [description]
- Task 2: [description]
...

PHASE [N] BLOCKED: [Blocker description]
- Issue: [what's wrong]
- Need: [what's needed to unblock]

PHASE [N] COMPLETE: [Phase Name]
- Deliverable 1: ✅ [description]
- Deliverable 2: ✅ [description]
- Next: [what happens next]
```

---

## Rollback Plan

### If Deploy Fails
1. Check GitHub Actions logs
2. Fix issue locally
3. Test `npm run build` and `npm run export`
4. Push fix to main
5. Re-trigger deploy

### If Supabase Fails
1. Verify anon key is correct
2. Check RLS policies (should allow public inserts)
3. Test with Supabase Studio SQL editor
4. Fall back to local JSON file if needed (Phase 1 only)

### If Agentmail Fails
1. Log error but don't block form submission
2. Store emails in Supabase for manual follow-up
3. Fix Agentmail integration in Phase 2

---

## Definition of Done (Overall)

- ✅ Site live at GitHub Pages URL
- ✅ Landing page complete with all sections
- ✅ Request access form functional
- ✅ Form submissions save to Supabase
- ✅ Confirmation emails send via Agentmail
- ✅ Dashboard shell exists (locked)
- ✅ Mobile responsive (tested on phone)
- ✅ Load time <2 seconds
- ✅ No console errors
- ✅ All links work
- ✅ Professional appearance (looks like real product)

---

## Post-Launch Tasks (Not in Scope)

- Set up analytics (Google Analytics or Plausible)
- Monitor waitlist signups
- Follow up with leads within 48 hours
- Iterate on copy based on conversion data
- Plan Phase 2 (functional product)

---

## Notes

- All agents should reference SPEC.md for content and design
- Commit messages should be clear and descriptive
- Test locally before pushing to main
- Keep dependencies minimal (only what's needed)
- Document any deviations from spec
