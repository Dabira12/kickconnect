import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

// Connects to data-controller="dropdown"

export default class extends Controller {
  static targets = [
    "categorySelect",
    "departmentSelect",
    "subCategorySelect",
    "sizeSelect",
    "courierSelect",
    "shippingPrice",
  ];

  onCourierSelect(event) {
    let selectedCourier = this.courierSelectTarget;

    let courierPrice =
      selectedCourier.options[selectedCourier.selectedIndex].dataset["amount"];
    let shippingTarget = this.shippingPriceTarget.id;

    get(
      `/order/courierselect?shippingTarget=${shippingTarget}&courierPrice=${courierPrice}`,
      {
        responseKind: "turbo-stream",
      }
    );
  }

  onDepartmentChange(event) {
    let department = event.target.selectedOptions[0].value;
    let target = this.categorySelectTarget.id;
    let subCategoryTarget = this.subCategorySelectTarget.id;
    let sizeTarget = this.sizeSelectTarget.id;
    let reset = "reset";
    // let category = this.categorySelectTarget.id;

    get(`/listings/categories?target=${target}&department=${department}`, {
      responseKind: "turbo-stream",
    });

    get(
      `/listings/subcategories?target=${subCategoryTarget}&category=${reset}&department=${reset}`,
      {
        responseKind: "turbo-stream",
      }
    );

    get(
      `/listings/sizes?target=${sizeTarget}&category=${reset}&department=${reset}`,
      {
        responseKind: "turbo-stream",
      }
    );
  }

  onCategoryChange(event) {
    let category = event.target.selectedOptions[0].value;
    let department = this.departmentSelectTarget.value;
    let target = this.subCategorySelectTarget.id;
    let sizeTarget = this.sizeSelectTarget.id;

    get(
      `/listings/subcategories?target=${target}&category=${category}&department=${department}`,
      {
        responseKind: "turbo-stream",
      }
    );

    get(
      `/listings/sizes?target=${sizeTarget}&category=${category}&department=${department}`,
      {
        responseKind: "turbo-stream",
      }
    );
  }

  onFormSubmit(event) {
    console.log("yes");
    event.stopImmediatePropagation();
  }

  test() {
    const url = new URL(window.location.href);
    let path = url.pathname.split("/");

    let listing = path[2];
    console.log(path[3]);
    if (path[3] != null && path[3] == "edit") {
      console.log("yes");
      let target = this.sizesSelectTarget.id;
      get(`/listings/sizes?target=${target}&selected=${path[2]}`, {
        responseKind: "turbo-stream",
      });
    }
  }
}
