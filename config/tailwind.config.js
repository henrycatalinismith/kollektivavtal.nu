const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  mode: 'jit',
  content: [
    './public/*.html',
    './app/builders/*.rb',
    './app/builders/**/*.rb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    fontFamily: {
      'major': ['"Major Mono Display", sans-serif'],
    },
    extend: {
      fontSize: {
        '10xl': '10rem',
      },
      screens: {
        xxs: '320px',
        xs: '380px',
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
