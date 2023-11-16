import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="visibility"
export default class extends Controller {
  static targets = ["profile"];
  connect() {}

  showMenu() {
    console.log(this.element);
    this.profileTarget.classList.toggle("hidden");
    console.log(this.profileTarget.hidden);
  }
}
