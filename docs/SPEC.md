# LeadPilot - Product Specification

## Overview
LeadPilot is an AI-powered customer communication assistant for small service businesses (HVAC, plumbing, electrical, etc.). It provides instant acknowledgment of customer inquiries and delivers formatted notifications to business owners.

**Current Phase:** Marketing site + waitlist (no functional product yet)

**Target Audience:** Small service businesses (1-10 employees) who lose leads due to slow response times.

---

## Product Vision

### Problem
Small service businesses lose 30-50% of leads because they respond too slowly to inquiries. Customers expect instant responses, but business owners are busy with jobs and can't monitor email 24/7.

### Solution
LeadPilot sits between the customer and the business:
1. **Instant acknowledgment** - Customer gets reply within 60 seconds
2. **Smart parsing** - AI extracts key info (service type, urgency, contact details)
3. **Owner notification** - Business owner gets formatted inquiry via email/SMS/Telegram
4. **Simple dashboard** - See all inquiries in one place

### Value Proposition
- Never miss a lead due to slow response
- Professional first impression (instant reply)
- Save time (organized, parsed inquiries)
- Close more deals (faster response = higher conversion)

---

## Phase 1: Marketing Site + Waitlist (Current)

### Objectives
1. Look like a legitimate, professional SaaS product
2. Collect interested businesses via "Request Early Access" form
3. Set expectations (early access, onboarding one business at a time)
4. Validate demand before building full product

### Scope

#### What We're Building
- **Landing page** with hero, features, how it works, pricing preview, CTA
- **Request access form** that stores leads in Supabase
- **Confirmation flow** (email sent via Agentmail)
- **Product shell** (locked dashboard to show it's real)
- **GitHub Pages deployment** with auto-deploy pipeline

#### What We're NOT Building Yet
- ❌ Functional product (no email processing)
- ❌ User authentication
- ❌ Dashboard functionality
- ❌ Payment processing
- ❌ Customer onboarding flow

---

## Technical Specification

### Tech Stack
- **Frontend:** Next.js 15 (App Router) with static export
- **Styling:** Tailwind CSS + Shadcn/ui components
- **Database:** Supabase (waitlist storage only)
- **Email:** Agentmail (confirmation emails)
- **Hosting:** GitHub Pages
- **Deployment:** GitHub Actions (auto-deploy on push to main)

### Architecture
```
┌─────────────────────────────────────────┐
│  Landing Page (Static Site)             │
│  - Hero, Features, Pricing, CTA         │
└───────────────┬─────────────────────────┘
                │
                ▼
┌─────────────────────────────────────────┐
│  Request Access Form                    │
│  - Name, Email, Business, Phone         │
└───────────────┬─────────────────────────┘
                │
                ▼
┌─────────────────────────────────────────┐
│  Supabase (Waitlist Table)              │
│  - Store lead info                      │
│  - Trigger webhook (future)             │
└───────────────┬─────────────────────────┘
                │
                ▼
┌─────────────────────────────────────────┐
│  Confirmation Email (Agentmail)         │
│  - "Thanks for your interest"           │
│  - "We'll reach out within 48 hours"    │
└─────────────────────────────────────────┘
```

### Repository Structure
```
leadpilot/
├── docs/
│   ├── SPEC.md                    # This file
│   ├── PLAN.md                    # Execution plan
│   └── TASKS.md                   # Task breakdown
├── src/
│   ├── app/
│   │   ├── page.tsx               # Landing page
│   │   ├── layout.tsx             # Root layout
│   │   ├── access/
│   │   │   └── page.tsx           # Request access form
│   │   ├── dashboard/
│   │   │   └── page.tsx           # Locked product shell
│   │   └── thank-you/
│   │       └── page.tsx           # Post-submission page
│   ├── components/
│   │   ├── landing/
│   │   │   ├── hero.tsx
│   │   │   ├── features.tsx
│   │   │   ├── how-it-works.tsx
│   │   │   ├── pricing.tsx
│   │   │   └── cta.tsx
│   │   ├── ui/                    # Shadcn components
│   │   └── access-form.tsx
│   └── lib/
│       ├── supabase.ts            # Supabase client
│       └── types.ts               # TypeScript types
├── public/
│   ├── images/
│   └── mockups/                   # Product screenshots
├── next.config.js                 # Static export config
├── tailwind.config.ts
├── tsconfig.json
├── package.json
└── .github/
    └── workflows/
        └── deploy.yml             # GitHub Pages deploy
```

### Database Schema (Supabase)

#### Table: `waitlist`
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

-- Index for fast lookups
CREATE INDEX idx_waitlist_email ON waitlist(email);
CREATE INDEX idx_waitlist_created_at ON waitlist(created_at DESC);
```

### Page Specifications

#### 1. Landing Page (`/`)

**Hero Section:**
- Headline: "Stop Losing Leads While You Sleep"
- Subheadline: "Your customers expect instant responses. LeadPilot acknowledges every inquiry in 60 seconds, then notifies you with everything you need to close the deal."
- Primary CTA: "Request Early Access" (button → `/access`)
- Secondary CTA: "See How It Works" (scroll to features)
- Hero image/animation: Mockup of dashboard or notification flow

**How It Works Section:**
1. **Connect Your Inbox**
   - Icon: Email/inbox
   - Text: "Forward contact form emails or use our embeddable form"
   
2. **AI Responds Instantly**
   - Icon: Lightning bolt/robot
   - Text: "Professional acknowledgment sent within 60 seconds"
   
3. **You Get Notified**
   - Icon: Phone/bell
   - Text: "Formatted inquiry delivered to your email, SMS, or Telegram"

**Features Section:**
- ⚡ **Instant Response** - Reply to customers in under 60 seconds, 24/7
- 🤖 **Smart Parsing** - AI extracts service type, urgency, and contact details
- 📱 **Multi-Channel Alerts** - Get notified via email, SMS, or Telegram
- 📊 **Simple Dashboard** - See all inquiries organized in one place
- ✍️ **Custom Templates** - Personalize auto-replies for your brand
- 🔒 **Secure & Private** - Your data never leaves our encrypted servers

**Social Proof Section:**
- Placeholder testimonials (3 fake ones for now)
- "Trusted by service businesses across the US"
- Logo placeholders for future customers

**Pricing Section:**
- **Starter** - $49/mo (up to 100 inquiries/month)
- **Pro** - $99/mo (up to 500 inquiries/month)
- **Enterprise** - Custom (unlimited inquiries, dedicated support)
- Badge: "Early access customers get 50% off for life"

**Final CTA:**
- "Join the Waitlist" button → `/access`

**Footer:**
- Logo
- Links: How It Works, Pricing, Contact
- Copyright notice
- "Built for small service businesses"

#### 2. Request Access Page (`/access`)

**Form Fields:**
- Name (required)
- Email (required, validated)
- Business Name (required)
- Phone (optional)
- Message (optional) - "Tell us about your business and how you handle customer inquiries"

**Form Behavior:**
- Client-side validation (email format, required fields)
- Submit → POST to Supabase
- Success → Redirect to `/thank-you`
- Error → Show inline error message

**Copy:**
- Headline: "Request Early Access"
- Subtext: "We're onboarding businesses one at a time to ensure quality. Submit your info and we'll reach out within 48 hours."

#### 3. Thank You Page (`/thank-you`)

**Content:**
- Headline: "You're on the list!"
- Body: "Thanks for your interest in LeadPilot. We'll review your submission and reach out within 48 hours to schedule a demo."
- CTA: "Back to Home" button

**Confirmation Email** (sent via Agentmail):
```
Subject: You're on the LeadPilot Waitlist

Hi [Name],

Thanks for requesting early access to LeadPilot!

We're onboarding service businesses one at a time to ensure 
every customer gets white-glove treatment. 

We'll reach out within 48 hours to:
- Learn about your business
- Show you how LeadPilot works
- Get you set up if it's a good fit

In the meantime, have questions? Just reply to this email.

- Koda
LeadPilot Team
```

#### 4. Dashboard Shell (`/dashboard`)

**State:** Locked/gated (no auth yet)

**Content:**
- Header: "LeadPilot Dashboard"
- Message: "Early Access Only"
- Subtext: "LeadPilot is currently in private beta. Request access at [link]."
- Mockup screenshot of what dashboard will look like
- CTA: "Request Access" button

---

## Design Guidelines

### Brand Identity
- **Colors:** 
  - Primary: Blue (#2563eb) - trust, professionalism
  - Accent: Green (#10b981) - success, growth
  - Neutral: Gray scale
- **Typography:** 
  - Headings: Inter (bold, modern)
  - Body: Inter (regular)
- **Tone:** Professional but approachable, direct, benefit-focused

### UI Principles
- Clean, minimal design
- Mobile-first responsive
- Fast loading (static site)
- High contrast for readability
- Clear CTAs (primary button stands out)

### Component Library
Use Shadcn/ui for:
- Buttons
- Form inputs
- Cards
- Badges
- Typography

---

## Success Metrics (Phase 1)

### Primary Metrics
- **Waitlist signups:** 20+ in first week
- **Conversion rate:** 10%+ of landing page visitors request access
- **Time to deploy:** <6 hours from spec to live site

### Validation Criteria
- Site loads in <2 seconds
- Mobile responsive (works on phone)
- Form submissions save to Supabase
- Confirmation emails send successfully
- Professional appearance (looks like a real product)

---

## Risks & Mitigations

### Risk 1: Low signup rate
**Mitigation:** Iterate on copy, test different headlines, collect feedback from contacts

### Risk 2: Technical issues with Supabase/Agentmail
**Mitigation:** Test thoroughly before launch, have fallback (email to personal address)

### Risk 3: Site doesn't look professional
**Mitigation:** Use proven Shadcn components, reference high-quality SaaS sites for inspiration

---

## Future Phases (Not in Scope)

### Phase 2: MVP Product (Weeks 2-3)
- Functional email processing
- Real auto-replies
- Owner notifications
- Basic dashboard with inquiry list

### Phase 3: Beta Launch (Week 4)
- User authentication
- Onboarding flow
- Settings/customization
- 5-10 pilot customers

### Phase 4: Public Launch (Week 6+)
- Payment processing
- Public signup (no waitlist)
- Marketing campaign
- Scale to 50+ customers

---

## Appendix

### Related Documents
- `PLAN.md` - Execution plan and timeline
- `TASKS.md` - Detailed task breakdown for sub-agents
- Repository: https://github.com/koda-agent299/leadpilot

### Contact
- Project Owner: Aaryush Gupta
- Developer: Koda (OpenClaw agent)
- Email: koda-agent299@agentmail.to
