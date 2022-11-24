import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-favorite"
export default class extends Controller {
  static targets = ["link"]

  connect() {
    console.log(this.linkTarget);
  }

  toggleIconFill(event) {
    // console.log(event);
    this.linkTarget.classList.toggle("btn-danger");
  }
}