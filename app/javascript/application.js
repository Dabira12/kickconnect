// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import '../stylesheets/application.css'

import "@hotwired/turbo-rails";
import "@hotwired/stimulus";
import "./controllers";
import * as ActiveStorage from "@rails/activestorage";

const swiper = new Swiper(".swiper", {
  // Optional parameters
  direction: "horizontal",

  // Navigation arrows
  navigation: {
    nextEl: ".swiper-button-next",
    prevEl: ".swiper-button-prev",
  },

  // And if we need scrollbar

  thumbs: {
    swiper: swiper,
    direction: "horizontal",
  },
});

ActiveStorage.start();
