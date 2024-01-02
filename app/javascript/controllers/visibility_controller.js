import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="visibility"
export default class extends Controller {
  static targets = ["profile", "flash", "mobilemenu"];
  connect() {}

  showMenu() {
    this.profileTarget.classList.toggle("hidden");
  }

  hideFlash() {
    console.log(this.flashTarget);
    this.flashTarget.classList.add("hidden");
  }

  showMobileMenu() {
    this.mobilemenuTarget.classList.toggle("hidden");
  }
}
