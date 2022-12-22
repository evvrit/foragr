import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-favorite"
export default class extends Controller {
  static targets = ["link", "card", "cacheCard", "popoverLink"];

  connect() {
    if (this.hasPopoverLinkTarget) {
      this.popover = new bootstrap.Popover(this.popoverLinkTarget);
    }
  }

  toggleIconFill() {
    ["fa-regular", "fa-solid"].map((v) => this.linkTarget.classList.toggle(v));

    if (this.hasPopoverLinkTarget) {
      this.togglePopover();
    }

    if (this.hasCacheCardTarget) {
      // console.log(this.cacheCardTarget);
      // console.log("hello");
      this.removeCacheCard();
    }
  }

  togglePopover() {
    if (this.linkTarget.classList.contains("fa-regular")) {
      this.popover.hide();
    } else if (this.linkTarget.classList.contains("fa-solid")) {
      this.popover.show();
      setTimeout(() => {
        this.popover.hide();
      }, "2000");
    }
  }

  removeCacheCard() {
    // console.log(this.cacheCardTarget);
    this.cacheCardTarget.classList.add("d-none");
  }
}
