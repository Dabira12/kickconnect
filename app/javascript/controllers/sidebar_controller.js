import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["name"];

  /*click() {
    console.log( this.nameTarget.classList)
    console.log( this.nameTarget.innerHTML)
    if (this.nameTarget.classList[1] == 'active'){
     
      this.nameTarget.classList.remove('active')
      
    }

    else{
    
      this.nameTarget.classList.add('active')
    
    }

    console.log( this.nameTarget.classList)

   
      
    
  }*/

  click(e) {
    const activeButton = this.element.querySelector(".bg-gray-50");

    console.log(activeButton.classList);

    if (activeButton) {
      activeButton.classList.remove("bg-gray-50");
    }

    e.target.classList.add("bg-gray-50");
  }
}
