import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="tom-select"
export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.form = document.getElementById("log-form");

    const tom = new TomSelect(this.element);

    if (this.form) {
      tom.settings.placeholder = "Cache";
    } else {
      tom.settings.placeholder = "Species";
    }

    tom.inputState();
  }
}
