import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="go-home"
export default class extends Controller {
  static targets = ["username"]

  connect() {
  }

  clickHiddenLink() {
    this.link.click();
  }
}
