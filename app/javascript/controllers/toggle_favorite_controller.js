import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-favorite"
export default class extends Controller {
  static targets = ["link"]

  connect() {
    console.log(this.linkTarget);
  }

  toggleIconFill(event) {
    // console.log(this.linkTarget);
    // this.linkTarget.className == 'fa-solid fa-heart-circle-minus fa-2xl' ? 'fa-solid fa-heart-circle-plus fa-2xl' : 'fa-solid fa-heart-circle-minus fa-2xl';
    ['fa-heart-circle-plus', 'fa-heart-circle-minus'].map(v=> this.linkTarget.classList.toggle(v) )
  }
}
