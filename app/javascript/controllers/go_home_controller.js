import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="go-home"
export default class extends Controller {
  static targets = ["username"]

  connect() {
    this.link = document.getElementById("go-home-link")
    // console.log(this.link);
  }

  clickHiddenLink() {
    this.link.click();
  }
}
