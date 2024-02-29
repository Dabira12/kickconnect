// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import '../stylesheets/application.css'

import "@hotwired/turbo-rails";

// import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = false; // turns off turbo for application. To use turbo on a page add data-turbo="true" to div. This was done because turbo affect the carousel

import "@hotwired/stimulus";
import "./add_jquery";

import "./controllers";
import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();

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
