// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import '../stylesheets/application.css'

// import "@hotwired/turbo-rails";

import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = false;
import "@hotwired/stimulus";
import "./controllers";
import * as ActiveStorage from "@rails/activestorage";

const swiper = new Swiper(".swiper", {
  // Optional parameters
  direction: "horizontal",

  loop: true,
  observer: true,
  init: true,
  lazyPreloadPrevNext: 6,

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
