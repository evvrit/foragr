import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select";

// Connects to data-controller="tom-select"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    // console.log(this.inputTargets.length);
    this.form = document.getElementById("log-form");
    // console.log(this.form);

    const tom = new TomSelect(this.element)

    if (this.form) {
      console.log(this.form);
      tom.settings.placeholder = "Cache";
    } else {
      tom.settings.placeholder = "Species";
    }

    tom.inputState();
  }
}
