# LeadPilot - Task Breakdown

**Reference Documents:**
- SPEC.md - Product specification
- PLAN.md - Execution plan and timeline

---

## Phase 1: Project Setup (30 minutes)

### Task 1.1: Initialize Next.js Project (10 min)
**Owner:** Agent 1 (Setup & Infrastructure)

**Steps:**
1. Create new directory: `mkdir -p /home/ubuntu/.openclaw/workspace/leadpilot`
2. Initialize Next.js:
   ```bash
   cd /home/ubuntu/.openclaw/workspace/leadpilot
   npx create-next-app@latest . --typescript --tailwind --app --no-src-dir --import-alias "@/*"
   ```
3. Configure static export in `next.config.js`:
   ```javascript
   /** @type {import('next').NextConfig} */
   const nextConfig = {
     output: 'export',
     images: {
       unoptimized: true
     },
     basePath: '/leadpilot',
     assetPrefix: '/leadpilot/'
   }
   module.exports = nextConfig
   ```
4. Install Shadcn/ui:
   ```bash
   npx shadcn-ui@latest init
   ```
5. Install additional dependencies:
   ```bash
   npm install @supabase/supabase-js
   ```
6. Create project structure:
   ```bash
   mkdir -p components/landing components/ui lib public/images public/mockups
   ```

**Acceptance Criteria:**
- ✅ `npm run dev` starts dev server
- ✅ `npm run build` generates static export in `out/`
- ✅ Project structure matches SPEC.md

---

### Task 1.2: Set Up Supabase (10 min)
**Owner:** Agent 1 (Setup & Infrastructure)

**Steps:**
1. Create Supabase project:
   - Go to https://supabase.com/dashboard
   - Create new project: "leadpilot" (free tier)
   - Save project URL and anon key

2. Create database schema:
   ```sql
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
   
   CREATE INDEX idx_waitlist_email ON waitlist(email);
   CREATE INDEX idx_waitlist_created_at ON waitlist(created_at DESC);
   ```

3. Set up RLS policy:
   ```sql
   ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;
   
   CREATE POLICY "Allow public inserts"
   ON waitlist FOR INSERT
   TO anon
   WITH CHECK (true);
   
   CREATE POLICY "Allow public reads for own email"
   ON waitlist FOR SELECT
   TO anon
   USING (email = current_setting('request.jwt.claims', true)::json->>'email');
   ```

4. Create `.env.local`:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
   AGENTMAIL_API_KEY=am_e17c377fe34b8d719ea2b47d6b1007c90fb2667b5bf269f5e8236f55751d99be
   ```

5. Add `.env.local` to `.gitignore`

**Acceptance Criteria:**
- ✅ Supabase project created
- ✅ `waitlist` table exists with correct schema
- ✅ RLS policies configured
- ✅ Environment variables set

---

### Task 1.3: GitHub Repository & Deploy Pipeline (10 min)
**Owner:** Agent 1 (Setup & Infrastructure)

**Steps:**
1. Create GitHub repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Next.js setup"
   ```
   
2. Create repo on GitHub (using GitHub CLI or web):
   ```bash
   # If using gh CLI:
   gh repo create koda-agent299/leadpilot --public --source=. --push
   ```

3. Create GitHub Actions workflow `.github/workflows/deploy.yml`:
   ```yaml
   name: Deploy to GitHub Pages
   
   on:
     push:
       branches: [main]
     workflow_dispatch:
   
   permissions:
     contents: read
     pages: write
     id-token: write
   
   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: actions/setup-node@v4
           with:
             node-version: '20'
             cache: 'npm'
         - run: npm ci
         - run: npm run build
         - name: Upload artifact
           uses: actions/upload-pages-artifact@v3
           with:
             path: ./out
   
     deploy:
       needs: build
       runs-on: ubuntu-latest
       environment:
         name: github-pages
         url: ${{ steps.deployment.outputs.page_url }}
       steps:
         - name: Deploy to GitHub Pages
           id: deployment
           uses: actions/deploy-pages@v4
   ```

4. Enable GitHub Pages in repo settings:
   - Settings → Pages
   - Source: GitHub Actions

5. Create `.gitignore`:
   ```
   node_modules/
   .next/
   out/
   .env.local
   .DS_Store
   ```

**Acceptance Criteria:**
- ✅ Repository exists at `https://github.com/koda-agent299/leadpilot`
- ✅ GitHub Actions workflow configured
- ✅ Initial commit pushed
- ✅ GitHub Pages enabled

---

## Phase 2: Landing Page (2 hours)

### Task 2.1: Hero Section (30 min)
**Owner:** Agent 2 (Landing Page)

**Steps:**
1. Create `components/landing/hero.tsx`:
   ```typescript
   export function Hero() {
     return (
       <section className="container mx-auto px-4 py-20">
         <div className="max-w-4xl mx-auto text-center">
           <h1 className="text-5xl font-bold mb-6">
             Stop Losing Leads While You Sleep
           </h1>
           <p className="text-xl text-gray-600 mb-8">
             Your customers expect instant responses. LeadPilot acknowledges 
             every inquiry in 60 seconds, then notifies you with everything 
             you need to close the deal.
           </p>
           <div className="flex gap-4 justify-center">
             <Button size="lg" asChild>
               <Link href="/access">Request Early Access</Link>
             </Button>
             <Button size="lg" variant="outline" onClick={() => scrollTo('#how-it-works')}>
               See How It Works ↓
             </Button>
           </div>
         </div>
       </section>
     )
   }
   ```

2. Add to `app/page.tsx`

3. Style with Tailwind

**Acceptance Criteria:**
- ✅ Hero section renders with correct copy
- ✅ CTAs link correctly
- ✅ Responsive on mobile

---

### Task 2.2: How It Works Section (20 min)
**Owner:** Agent 2 (Landing Page)

**Steps:**
1. Create `components/landing/how-it-works.tsx`
2. Add 3 steps with icons:
   - Connect Your Inbox (icon: Inbox)
   - AI Responds Instantly (icon: Zap)
   - You Get Notified (icon: Bell)
3. Use Lucide icons from Shadcn
4. Grid layout: 1 col mobile, 3 col desktop

**Acceptance Criteria:**
- ✅ 3 steps displayed in order
- ✅ Icons from Lucide
- ✅ Responsive grid

---

### Task 2.3: Features Section (30 min)
**Owner:** Agent 2 (Landing Page)

**Steps:**
1. Create `components/landing/features.tsx`
2. Add 6 feature cards:
   - Instant Response
   - Smart Parsing
   - Multi-Channel Alerts
   - Simple Dashboard
   - Custom Templates
   - Secure & Private
3. Each card: icon + title + description
4. Grid: 1/2/3 columns (mobile/tablet/desktop)

**Acceptance Criteria:**
- ✅ 6 feature cards
- ✅ Consistent styling
- ✅ Responsive grid

---

### Task 2.4: Pricing Section (20 min)
**Owner:** Agent 2 (Landing Page)

**Steps:**
1. Create `components/landing/pricing.tsx`
2. Add 3 pricing tiers:
   - Starter: $49/mo (100 inquiries)
   - Pro: $99/mo (500 inquiries)
   - Enterprise: Custom (unlimited)
3. Add badge: "Early access 50% off for life"
4. CTA button for each tier → `/access`

**Acceptance Criteria:**
- ✅ 3 pricing cards
- ✅ Badge visible
- ✅ CTAs work

---

### Task 2.5: Social Proof Section (10 min)
**Owner:** Agent 2 (Landing Page)

**Steps:**
1. Create `components/landing/testimonials.tsx`
2. Add 3 placeholder testimonials:
   - "Cut response time from 4 hours to 60 seconds" - Mike R., HVAC Contractor
   - "Never miss a lead again, even when I'm on a job site" - Sarah L., Electrician
   - "My customers love the instant acknowledgment" - Tom B., Plumber
3. Add "Trusted by service businesses across the US"

**Acceptance Criteria:**
- ✅ 3 testimonials displayed
- ✅ Professional styling

---

### Task 2.6: Footer (10 min)
**Owner:** Agent 2 (Landing Page)

**Steps:**
1. Create `components/footer.tsx`
2. Add:
   - Logo/brand name
   - Links: How It Works, Pricing, Contact (dummy links for now)
   - Copyright: "© 2026 LeadPilot. Built for small service businesses."
3. Responsive layout

**Acceptance Criteria:**
- ✅ Footer on all pages
- ✅ Links present (even if dummy)

---

## Phase 3: Request Access Form (1 hour)

### Task 3.1: Form UI & Validation (20 min)
**Owner:** Agent 3 (Form & Data Flow)

**Steps:**
1. Create `components/access-form.tsx`
2. Add form fields:
   ```typescript
   interface FormData {
     name: string;
     email: string;
     business_name: string;
     phone?: string;
     message?: string;
   }
   ```
3. Client-side validation:
   - Required: name, email, business_name
   - Email format validation
   - Show error states
4. Submit button with loading state

**Acceptance Criteria:**
- ✅ Form renders correctly
- ✅ Validation works before submit
- ✅ Error messages clear

---

### Task 3.2: Supabase Integration (20 min)
**Owner:** Agent 3 (Form & Data Flow)

**Steps:**
1. Create `lib/supabase.ts`:
   ```typescript
   import { createClient } from '@supabase/supabase-js'
   
   export const supabase = createClient(
     process.env.NEXT_PUBLIC_SUPABASE_URL!,
     process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
   )
   ```

2. Create `app/api/waitlist/route.ts` (API route):
   ```typescript
   export async function POST(request: Request) {
     const data = await request.json();
     const { error } = await supabase
       .from('waitlist')
       .insert([data]);
     
     if (error) {
       return Response.json({ error: error.message }, { status: 400 });
     }
     
     return Response.json({ success: true });
   }
   ```

3. Handle form submission in `components/access-form.tsx`
4. Redirect to `/thank-you` on success

**Acceptance Criteria:**
- ✅ Form submits to Supabase
- ✅ Duplicate email shows friendly error
- ✅ Success redirects to thank-you page

---

### Task 3.3: Thank You Page (10 min)
**Owner:** Agent 3 (Form & Data Flow)

**Steps:**
1. Create `app/thank-you/page.tsx`
2. Add success message:
   - "You're on the list!"
   - "We'll reach out within 48 hours"
3. CTA: "Back to Home" button

**Acceptance Criteria:**
- ✅ Page exists at `/thank-you`
- ✅ Message is clear
- ✅ CTA works

---

### Task 3.4: Confirmation Email (10 min)
**Owner:** Agent 3 (Form & Data Flow)

**Steps:**
1. Create `lib/agentmail.ts`:
   ```typescript
   import { AgentMail } from 'agentmail';
   
   const client = new AgentMail({
     apiKey: process.env.AGENTMAIL_API_KEY!
   });
   
   export async function sendConfirmationEmail(email: string, name: string) {
     await client.inboxes.messages.send({
       inbox_id: "koda-agent299@agentmail.to",
       to: email,
       subject: "You're on the LeadPilot Waitlist",
       text: `Hi ${name},\n\nThanks for requesting early access...`
     });
   }
   ```

2. Call from API route after Supabase insert
3. Handle errors silently (don't block form submission)

**Acceptance Criteria:**
- ✅ Email sent on form submission
- ✅ Email arrives within 60 seconds
- ✅ Email failure doesn't break form

---

## Phase 4: Product Shell (1.5 hours)

### Task 4.1: Dashboard Shell Page (30 min)
**Owner:** Agent 4 (Product Shell & Mockups)

**Steps:**
1. Create `app/dashboard/page.tsx`
2. Add layout:
   - Header with logo
   - "Early Access Only" message
   - CTA: "Request Access" button → `/access`
   - Mockup screenshot (placeholder for now)
3. Style as locked/gated state

**Acceptance Criteria:**
- ✅ Page exists at `/dashboard`
- ✅ Clear it's locked (not broken)
- ✅ CTA works

---

### Task 4.2: Dashboard Mockup Design (45 min)
**Owner:** Agent 4 (Product Shell & Mockups)

**Steps:**
1. Design mockup with fake data:
   - Header: "LeadPilot Dashboard"
   - Stats bar: "12 Inquiries Today | 2.3min Avg Response"
   - Table with columns:
     - Customer Name
     - Service Type
     - Received
     - Status
   - Sidebar: Dashboard, Inquiries, Settings, Account
2. Create as image (screenshot or Figma export)
3. Save to `public/mockups/dashboard.png`
4. Add to dashboard shell page

**Acceptance Criteria:**
- ✅ Mockup looks realistic
- ✅ Shows what product will do
- ✅ Professional design

---

### Task 4.3: Site Navigation (15 min)
**Owner:** Agent 4 (Product Shell & Mockups)

**Steps:**
1. Create `components/nav.tsx`
2. Add:
   - Logo (left)
   - Links: How It Works, Pricing, Dashboard
   - CTA: "Request Access" button (right)
3. Add to `app/layout.tsx`
4. Mobile hamburger menu

**Acceptance Criteria:**
- ✅ Navigation on all pages
- ✅ Links work
- ✅ Mobile responsive

---

## Phase 5: Polish & Deploy (1 hour)

### Task 5.1: Mobile Testing & Fixes (20 min)
**Owner:** Agent 5 (Polish & Deploy)

**Steps:**
1. Test at widths: 375px, 768px, 1024px, 1440px
2. Fix any layout breaks:
   - Text overflow
   - Button sizes (min 44px height)
   - Image scaling
   - Navigation collapse
3. Check font sizes (min 16px for inputs to prevent zoom)

**Acceptance Criteria:**
- ✅ No horizontal scroll on mobile
- ✅ All text readable
- ✅ Buttons tappable

---

### Task 5.2: Performance Optimization (15 min)
**Owner:** Agent 5 (Polish & Deploy)

**Steps:**
1. Optimize images:
   - Compress with TinyPNG
   - Use WebP format
   - Add width/height attributes
2. Check bundle size: `npm run build`
3. Ensure static export generates clean HTML

**Acceptance Criteria:**
- ✅ Images optimized
- ✅ Bundle size reasonable (<500KB JS)
- ✅ Fast load time

---

### Task 5.3: Final Testing (15 min)
**Owner:** Agent 5 (Polish & Deploy)

**Steps:**
1. Test form submission:
   - Fill out form
   - Check Supabase for record
   - Verify redirect to thank-you
   - Check confirmation email
2. Test all navigation:
   - Click every link
   - Verify no 404s
3. Proofread all copy:
   - Check for typos
   - Verify consistency with SPEC.md

**Acceptance Criteria:**
- ✅ Form works end-to-end
- ✅ All links functional
- ✅ No typos

---

### Task 5.4: Deploy (10 min)
**Owner:** Agent 5 (Polish & Deploy)

**Steps:**
1. Commit all changes:
   ```bash
   git add .
   git commit -m "Complete landing page and waitlist form"
   git push origin main
   ```
2. Monitor GitHub Actions:
   - Watch workflow run
   - Check for errors
3. Verify deployment:
   - Visit `https://koda-agent299.github.io/leadpilot/`
   - Test on mobile device
   - Submit test form

**Acceptance Criteria:**
- ✅ GitHub Actions succeeds
- ✅ Site live on GitHub Pages
- ✅ All features work in production

---

## Checklist (Overall Completion)

### Functional Requirements
- [ ] Landing page with all sections
- [ ] Request access form
- [ ] Form saves to Supabase
- [ ] Confirmation email sends
- [ ] Thank you page
- [ ] Dashboard shell (locked)
- [ ] Site navigation
- [ ] Mobile responsive

### Technical Requirements
- [ ] Static export configured
- [ ] GitHub Actions deploy pipeline
- [ ] Environment variables set
- [ ] Supabase RLS policies
- [ ] Error handling

### Quality Requirements
- [ ] No console errors
- [ ] Load time <2 seconds
- [ ] Professional design
- [ ] Copy matches SPEC.md
- [ ] Mobile tested (375px width)

---

## Handoff Notes

### For Sub-Agents
- Reference SPEC.md for all content and design
- Commit after each completed task
- Test locally before pushing
- Report any blockers immediately
- Keep code clean and commented

### For Coordinator (Koda)
- Monitor progress of each phase
- Unblock agents if stuck
- Review code before merge (if needed)
- Test final deployment
- Document any deviations from spec
