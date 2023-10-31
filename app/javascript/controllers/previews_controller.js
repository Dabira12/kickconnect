import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="previews"
export default class extends Controller {
  static targets = ["input", "preview"];
  connect() {
    console.log("Hello world", this.element);
  }

  preview() {
    //TODO

    let input = this.inputTarget;

    let preview = this.previewTarget;

    let file = input.files[0];

    console.log(input);
    // console.log(file);
    let reader = new FileReader();

    reader.onloadend = function () {
      console.log(preview);
      preview.src = reader.result;
    };

    if (file) {
      reader.readAsDataURL(file);
    } else {
      preview.src = "";
    }
  }
}
