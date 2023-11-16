const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
      backgroundImage: {
        hero: "url('texture.jpg')",
        custom: "url('custom.png')",
        custom_one: "url(custom1.png)",
        custom_two: "url(custom2.png) ",
        custom_three: "url(custom3.png)",
        custom_five: "url(custom5.png)",
        custom_six: "url(custom6.png)",
        custom_seven: "url(custom7.png)",
        custom_eight: "url(custom8.png)",
        custom_nine: "url(custom9.png)",
        dotted: "url(dotted.svg)",
        squares: "url(squares.jpeg)",
        cross: "url(cross.png)",
        squares_two: "url(squares2.png)",
        grid: "url(green-grid.jpg)",
        vec: "url(vec.jpg)",
        paper: "url(grid-paper-01.jpg)",
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
