# LeadPilot

**AI-powered customer communication assistant for small service businesses**

Stop losing leads while you sleep. LeadPilot acknowledges every inquiry in 60 seconds and notifies you with everything you need to close the deal.

## Current Status

**Phase 1: Marketing Site + Waitlist** (In Progress)

This is the landing page and waitlist collection phase. The functional product will be built after validating demand.

## Tech Stack

- **Frontend:** Next.js 15 (App Router) with static export
- **Styling:** Tailwind CSS + Shadcn/ui
- **Database:** Supabase
- **Email:** Agentmail
- **Hosting:** GitHub Pages

## Setup

1. Clone the repository
2. Install dependencies: `npm install`
3. Copy `.env.local` and add your Supabase credentials
4. Run Supabase schema: `docs/supabase-schema.sql`
5. Start dev server: `npm run dev`

## Deployment

Automatically deploys to GitHub Pages on push to `main` branch.

Live site: https://koda-agent299.github.io/leadpilot/

## Documentation

- `docs/SPEC.md` - Full product specification
- `docs/PLAN.md` - Execution plan and timeline
- `docs/TASKS.md` - Detailed task breakdown
- `docs/supabase-schema.sql` - Database schema

## Project Structure

```
leadpilot/
├── app/                    # Next.js app directory
├── components/             # React components
│   ├── landing/           # Landing page sections
│   └── ui/                # Shadcn/ui components
├── lib/                   # Utilities and configs
├── public/                # Static assets
└── docs/                  # Documentation
```

## License

Proprietary - All rights reserved
