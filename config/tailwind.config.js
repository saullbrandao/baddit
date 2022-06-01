const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  darkMode: "media",
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      keyframes: {
        fade: {
          '0%': { opacity: 0 },
          '5%': { opacity: 1 },
          '60%': { opacity: 1 },
          '100%': { opacity: 0 },
        },
      },
      animation: {
        fade: 'fade 4s ease-in-out',
      },
      colors: {
        light: {
          bg: '#dae0e6',
          'bg-alt': '#ffffff',
          divide: '#dae0e6',
        },
        dark: {
          bg: '#030303',
          'bg-alt': '#1a1a1b',
          divide: '#343536',
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
