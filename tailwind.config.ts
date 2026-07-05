import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        // Warm dark base — netral gelap hangat, serasi logo oranye
        'h-bg':     '#120c07',
        'h-dark':   '#1a110a',
        'h-card':   '#221710',
        'h-border': '#38281c',
        // Brand oranye — sesuai logo CK
        'h-red':    '#EE7220',
        'h-red-d':  '#C25812',
        // Aksen kabut (teks aksen, detail premium)
        'h-cream':  '#F6C193',
        'h-muted':  '#95867a',
      },
      fontFamily: {
        sans:  ['var(--font-dm-sans)', 'sans-serif'],
        serif: ['var(--font-playfair)', 'serif'],
      },
    },
  },
  plugins: [],
}

export default config
