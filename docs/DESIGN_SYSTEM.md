# Strategic Minds Design Law

The **Strategic Minds Advisory** brand expresses rigor, absolute clarity, and high-value strategic authority. The APEX OS frontend must strictly reflect these design laws to maintain consistency across all client touchpoints.

## Core Design Tokens

### 1. Palette
*   **Sidebar Black (`#000000`)**: Deep obsidian block. Used for sidebar, navigation zones, and branding.
*   **Advisory Gold (`#f8b800`)**: High-contrast, premium accents. Used for badges, primary interactive states, key metrics, and focus markers.
*   **Base Gray (`#f0f0f0`)**: Subtle background color. Muted canvas allowing content and dashboard tiles to breathe.
*   **Typography Primary (`#1a1a1a`)**: Near-black text. Ensures elite contrast and high readability.

### 2. Geometry
*   **Sidebar Width**: Fixed `240px`. It never collapses on desktop view.
*   **Font Family**: `Inter` sans-serif. Clean, geometric, neutral, high clarity.
*   **Borders & Radii**: Roundings must not exceed `8px` (`rounded-lg` or `rounded-md`). Keep lines sharp, thin, and premium.

## Code-level Token Mapping (Tailwind)

```typescript
// tailwind.config.ts
const config: Config = {
  theme: {
    extend: {
      colors: {
        strategic: {
          black: '#000000',
          gold: '#f8b800',
          gray: '#f0f0f0',
          dark: '#1a1a1a',
        },
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
    },
  },
}
```
