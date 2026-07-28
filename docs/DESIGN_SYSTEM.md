# Strategic Minds Design System — Permanent Law

## Colors (non-negotiable)
- Sidebar background: #000000 (true black, 240px fixed width)
- Primary accent / CTAs: #f8b800 (gold)
- Application background: #f0f0f0 (light gray)
- Content panels: #ffffff (white)
- Text primary: #111111
- Text secondary: #666666
- Error / destructive: #ef4444

## Typography
- Font family: Inter (Google Fonts)
- Minimum body size: 17px
- Heading weights: 700 (h2-h3), 900 (h1)
- Heading style: condensed, uppercase for main titles
- Letter spacing: -0.02em for large headings

## Layout
- Sidebar: 240px fixed, left side, full height, #000000
- Top bar: 56px, white, 1px border-bottom
- Content area: flex-1, #f0f0f0, padding 24px
- Content panels: white cards, border-radius 8px, subtle shadow
- KPI row: 4 tiles, 2x2 on mobile

## Components
- Primary button: #f8b800 bg, #000000 text, border-radius 6px, font-weight 700
- Nav active item: #f8b800 text + left border 3px #f8b800
- Nav hover: #1a1a1a bg
- Cards: white bg, 1px border #e5e5e5, border-radius 8px
- Tables: white bg, alternating #f9f9f9 rows
- Loading states: skeleton (not spinners)

## FAANG Standards
- PageSpeed: Performance ≥85, Accessibility ≥95, SEO ≥95, Best Practices ≥90
- TypeScript: zero errors (tsc --noEmit)
- ESLint: zero errors
- No console.log in production
- No hardcoded API keys in client code
- All forms: validated, error states, success states
- All images: Next.js Image component, alt text required
- Mobile: fully responsive, hamburger nav on <768px
- Loading skeletons on all async data

## Forbidden
- No bg-white or bg-black Tailwind hardcoded colors (use design tokens)
- No inline style="color: ..." overrides
- No spinner-based loading (use skeletons)
- No unhandled Promise rejections in production
- No TODO comments in committed code
