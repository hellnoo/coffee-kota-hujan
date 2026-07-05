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
        // Cool dark base — terinspirasi langit hujan & kabut
        'h-bg':     '#070b0f',
        'h-dark':   '#0d141b',
        'h-card':   '#111a23',
        'h-border': '#223140',
        // Brand biru hujan (fill: tombol, border, blok)
        'h-red':    '#1B5E86',
        'h-red-d':  '#123F5C',
        // Aksen kabut (teks aksen, detail premium)
        'h-cream':  '#AFD3E8',
        'h-muted':  '#7d8b96',
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
