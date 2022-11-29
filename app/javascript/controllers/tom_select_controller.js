import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select";

// Connects to data-controller="tom-select"
export default class extends Controller {
  static targets = ["input"]
  connect() {
    // console.log(this.inputTargets.length);
    new TomSelect(this.element)
  }
}
