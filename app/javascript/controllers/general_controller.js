import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="general"
export default class extends Controller {
  static values = { price: Number, listingid: Number, txref: String };
  static targets = ["bankName", "bankCode"];

  connect() {}

  copyClipboard() {
    navigator.clipboard.writeText(window.location.href);
  }

  makePayment() {
    console.log(this.listingidValue);
    console.log();
    FlutterwaveCheckout({
      public_key: "FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X",
      tx_ref: this.txrefValue,
      amount: this.priceValue,
      currency: "NGN",
      payment_options: "card, banktransfer, ussd",
      redirect_url:
        "http://localhost:3000/order/confirm/" + this.listingidValue,
      meta: {
        consumer_id: 23,
        consumer_mac: "92a3-912ba-1192a",
        listing_id: this.listingidValue,
      },
      customer: {
        email: "dab@yahoo.com",
        phone_number: "08102909304",
        name: "Rose De Bukater",
      },
      customizations: {
        title: "Entyque",
        description: "Payment for an awesome cruise",
        logo: "https://www.logolynx.com/images/logolynx/22/2239ca38f5505fbfce7e55bbc0604386.jpeg",
      },
    });
  }

  setBankName() {
    let selectedBank = this.bankCodeTarget;
    let bankName = selectedBank.options[selectedBank.selectedIndex].innerHTML;
    this.bankNameTarget.value = bankName;
  }
}
