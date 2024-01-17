import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Hello world", this.element);
  }
  hideModal() {
    this.element.parentElement.removeAttribute("src"); // it might be nice to also remove the modal SRC
    this.element.remove();
  }

  submitEnd(e) {
    console.log("yeso");
    console.log(e.detail);
    if (e.detail.success == true) {
      this.hideModal();
    }
    window.location.reload();
  }
}
