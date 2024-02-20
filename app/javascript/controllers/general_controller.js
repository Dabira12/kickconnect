import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

// Connects to data-controller="general"
export default class extends Controller {
  static values = {
    price: Number,
    listingid: Number,
    txref: String,
    shipmentid: String,
    carrier: String,
  };
  static targets = ["bankName", "bankCode", "courierSelect", "shippingPrice"];

  connect() {
    console.log(document.readyState);
    console.log(this.shipmentIdValue);
  }

  copyClipboard() {
    navigator.clipboard.writeText(window.location.href);
  }

  onCourierSelect(event) {
    let selectedCourier = this.courierSelectTarget;

    let courierPrice =
      selectedCourier.options[selectedCourier.selectedIndex].dataset["amount"];
    this.carrierValue =
      selectedCourier.options[selectedCourier.selectedIndex].dataset["carrier"];
    let shippingTarget = this.shippingPriceTarget.id;

    get(
      `/order/courierselect?shippingTarget=${shippingTarget}&courierPrice=${courierPrice}`,
      {
        responseKind: "turbo-stream",
      }
    );
  }

  makePayment() {
    if (this.courierSelectTarget.value != "") {
      console.log(this.courierSelectTarget.value);
      console.log(this.shipmentidValue);
      FlutterwaveCheckout({
        public_key: "FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X",
        tx_ref: this.txrefValue,
        amount: this.priceValue,
        currency: "NGN",
        payment_options: " card,banktransfer, ussd",
        redirect_url:
          "http://localhost:3000/order/confirm/" +
          this.listingidValue +
          "?" +
          "rate_id=" +
          this.courierSelectTarget.value +
          "&" +
          "shipment_id=" +
          this.shipmentidValue +
          "&" +
          "carrier=" +
          this.carrierValue,
        meta: {
          listing_id: this.listingidValue,
        },
        customer: {
          email: "dab@yahoo.com",
          phone_number: "08102909304",
          name: "Rose De Bukater",
        },
        customizations: {
          title: "Enthrift",
        },
      });
    }
  }

  setBankName() {
    let selectedBank = this.bankCodeTarget;
    let bankName = selectedBank.options[selectedBank.selectedIndex].innerHTML;
    this.bankNameTarget.value = bankName;
  }
}
