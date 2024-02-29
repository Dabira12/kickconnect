import { Controller } from "@hotwired/stimulus";
import { get, put } from "@rails/request.js";
import { FetchRequest } from "@rails/request.js";

// Connects to data-controller="general"
export default class extends Controller {
  static values = {
    price: Number,
    listingid: Number,
    txref: String,
    shipmentid: String,
    carrierName: String,
    email: String,
    courierPrice: Number,
  };
  static targets = ["bankName", "bankCode", "courierSelect", "shippingPrice"];

  connect() {}

  copyClipboard() {
    navigator.clipboard.writeText(window.location.href);
  }

  onCourierSelect(event) {
    let selectedCourier = this.courierSelectTarget;

    let courierPrice =
      selectedCourier.options[selectedCourier.selectedIndex].dataset["amount"];

    this.courierPriceValue = courierPrice;
    console.log(this.courierPriceValue);
    this.carrierNameValue =
      selectedCourier.options[selectedCourier.selectedIndex].dataset["carrier"];
    let shippingTarget = this.shippingPriceTarget.id;

    get(
      `/order/courierselect?shippingTarget=${shippingTarget}&courierPrice=${courierPrice}`,
      {
        responseKind: "turbo-stream",
      }
    );
  }

  // makePayment() {
  //   if (this.courierSelectTarget.value != "") {
  //     console.log(this.courierSelectTarget);
  //     FlutterwaveCheckout({
  //       public_key: "FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X",
  //       tx_ref: this.txrefValue,
  //       amount: this.priceValue,
  //       currency: "NGN",
  //       payment_options: " card,banktransfer, ussd",
  //       redirect_url:
  //         "http://localhost:3000/order/confirm/" +
  //         this.listingidValue +
  //         "?" +
  //         "rate_id=" +
  //         this.courierSelectTarget.value +
  //         "&" +
  //         "shipment_id=" +
  //         this.shipmentidValue +
  //         "&" +
  //         "carrier=" +
  //         this.carrierValue,
  //       meta: {
  //         listing_id: this.listingidValue,
  //       },
  //       customer: {
  //         email: "dab@yahoo.com",
  //         phone_number: "08102909304",
  //         name: "Rose De Bukater",
  //       },
  //       customizations: {
  //         title: "Enthrift",
  //       },
  //     });
  //   }
  // }

  // <iframe style="position: fixed; top: 0px; left: 0px; z-index: 2147483647; border: none; opacity: 1; width: 100%; height: 100%;" allowtransparency="true" width="100%" height="100%" name="checkout" src="https://checkout-v3-ui-prod.f4b-flutterwave.com/?__=UEJGUHViS2V5PUZMV1BVQktfVEVTVC0yNmZlNWRmZWUyYmFjZmRmMzA4ZDVkYWU1OGVlYWQ5NS1YJnR4cmVmPUd6cW5FdE9ERlFiMGtqJmFtb3VudD00NTAmY3VycmVuY3k9TkdOJnBheW1lbnRfb3B0aW9ucz0lMjBjYXJkJTJDYmFua3RyYW5zZmVyJTJDJTIwdXNzZCZyZWRpcmVjdF91cmw9aHR0cCUzQSUyRiUyRmxvY2FsaG9zdCUzQTMwMDAlMkZvcmRlciUyRmNvbmZpcm0lMkYyMiUzRnJhdGVfaWQlM0RSVC00MEcxSENFUTBPTkhWNTVYJTI2c2hpcG1lbnRfaWQlM0RTSC1IMTNIQ0ZEMk1YWDIzNkZXJTI2Y2FycmllciUzRFJlZHN0YXIlMjBFeHByZXNzJmN1c3RvbWVyX2ZpcnN0bmFtZT1Sb3NlJmN1c3RvbWVyX2xhc3RuYW1lPURlJTIwQnVrYXRlciZjdXN0b21lcl9lbWFpbD1kYWIlNDB5YWhvby5jb20mY3VzdG9tZXJfcGhvbmU9MDgxMDI5MDkzMDQmY3VzdG9tX3RpdGxlPUVudGhyaWZ0JmluaXRfdXJsPWh0dHAlMjUzQSUyNTJGJTI1MkZsb2NhbGhvc3QlMjUzQTMwMDAlMjUyRm9yZGVyJTI1MkZsaXN0aW5ncyUyNTJGMjI="></iframe>

  // async makePayment() {
  //   console.log("yes");
  //   console.log(Document.referrer);
  //   console.log(window.location.href);
  //   if (this.courierSelectTarget.value != "") {
  //     console.log(this.courierSelectTarget);

  //     const request = new FetchRequest(
  //       "get",
  //       "http://localhost:3000/order/make_payment/" +
  //         "?" +
  //         "rate_id=" +
  //         this.courierSelectTarget.value +
  //         "&" +
  //         "rate_amount=" +
  //         this.courierPriceValue +
  //         "&" +
  //         "carrier_name=" +
  //         this.carrierNameValue +
  //         "&" +
  //         "shipment_id=" +
  //         this.shipmentidValue
  //     );
  //     const response = await request.perform();
  //     if (response.ok) {
  //       const body = await response.text;
  //       const auth = JSON.parse(body)["auth"];
  //       console.log(auth);
  //       // document.getElementsByName("checkout")[0].src =
  //       //   "https://checkout.paystack.com/zeb15pkn3em2mmv";

  //       // <iframe
  //       //   frameborder="0"
  //       //   allowtransparency="true"
  //       //   id="inline-checkout-fUEy6"
  //       //   src="https://checkout.paystack.com/popup"
  //       //   allowpaymentrequest="true"
  //       //   style="z-index: 2147483647; background: transparent; border: 0px none transparent; overflow: hidden; margin: 0px; padding: 0px; -webkit-tap-highlight-color: transparent; position: fixed; left: 0px; top: 0px; width: 100%; visibility: visible; height: 100%;"
  //       // ></iframe>;

  //       const iframe = document.createElement("iframe");
  //       iframe.name = "checkout";
  //       iframe.src = auth;
  //       iframe.allow = "payment";

  //       iframe.width = "100%";
  //       iframe.height = "100%";
  //       // iframe.style =
  //       //   "position: fixed; top: 0px; left: 0px; z-index: 2147483647; border: none; opacity: 1; width: 100%; height: 100%; display:block; background-color: lightblue";

  //       iframe.style =
  //         "z-index: 2147483647; background: transparent; border: 0px none transparent; overflow: hidden; margin: 0px; padding: 0px; -webkit-tap-highlight-color: transparent; position: fixed; left: 0px; top: 0px; width: 100%; visibility: visible; height: 100%;";
  //       document.body.append(iframe);
  //       document.getElementsByName("checkout").requestFullscreen();
  //       // Do whatever do you want with the response body
  //       // You also are able to call `response.html` or `response.json`, be aware that if you call `response.json` and the response contentType isn't `application/json` there will be raised an error.
  //     }
  //   }
  // }
  paystack_stuff(price, email) {
    const paystack_url = "https://api.paystack.co/transaction/initialize";
    var paystack_request = new XMLHttpRequest();

    paystack_request.onreadystatechange = function () {
      if (paystack_request.readyState == XMLHttpRequest.DONE) {
        // alert(
        //   JSON.parse(paystack_request.response)["data"]["authorization_url"]
        // );
        let auth_url = JSON.parse(paystack_request.response)["data"][
          "authorization_url"
        ];

        window.location.replace(auth_url);

        // const iframe = document.createElement("iframe");
        // iframe.name = "checkout";
        // iframe.src = auth_url;
        // iframe.allow = "payment";

        // iframe.width = "100%";
        // iframe.height = "100%";
        // iframe.style =
        //   "position: fixed; top: 0px; left: 0px; z-index: 2147483647; border: none; opacity: 1; width: 100%; height: 100%; display:block; background-color: lightblue";
        // document.body.append(iframe);
        // return JSON.parse(paystack_request.response)["data"][
        //   "authorization_url"
        // ];
      }
    };
    paystack_request.open("POST", paystack_url, true);
    paystack_request.setRequestHeader("Content-Type", "application/json");
    paystack_request.setRequestHeader(
      "Authorization",
      "Bearer sk_test_f5e08f614c79e9f908fc7b990a6b194ce94fe157"
    );
    let total_amount = parseFloat(this.courierPriceValue) + parseFloat(price);
    console.log(total_amount);
    paystack_request.send(
      JSON.stringify({
        amount: total_amount * 100,
        email: email,
        callback_url:
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
          this.carrierNameValue,
      })
    );
  }
  async makePayment() {
    let host = window.location.host;
    let protocol = window.location.protocol;
    console.log(host);
    console.log(protocol);
    if (this.courierSelectTarget.value != "") {
      const request = new FetchRequest(
        "get",
        protocol + "//" + host + "/current_user_email"
      );
      const response = await request.perform();

      const listing_id = window.location.href.split("/")[5];
      console.log(listing_id);

      const listing_request = new FetchRequest(
        "get",
        protocol + "//" + host + "/listing/get_listing_price/" + listing_id
      );

      const listing_response = await listing_request.perform();

      if (response.ok && listing_response.ok) {
        const body = await response.text;
        console.log(JSON.parse(body));
        const email = JSON.parse(body)["current_user_email"];

        const listing_body = await listing_response.text;
        console.log(JSON.parse(listing_body));
        const price = JSON.parse(listing_body)["price"];

        let paystack_response = this.paystack_stuff(price, email);

        // const paystack_response = paystack_request.response;

        // if (paystack_response.ok) {
        //   // const paystack_body = await paystack_response.text;
        //   auth_url = paystack_body["data"]["authorization_url"];

        //   const iframe = document.createElement("iframe");
        //   iframe.name = "checkout";
        //   iframe.src = auth_url;
        //   iframe.allow = "payment";

        //   iframe.width = "100%";
        //   iframe.height = "100%";
        //   iframe.style =
        //     "position: fixed; top: 0px; left: 0px; z-index: 2147483647; border: none; opacity: 1; width: 100%; height: 100%; display:block; background-color: lightblue";
        //   document.body.append(iframe);
        // }
      }
    }
  }

  setBankName() {
    let selectedBank = this.bankCodeTarget;
    let bankName = selectedBank.options[selectedBank.selectedIndex].innerHTML;
    this.bankNameTarget.value = bankName;
  }
}
