import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-favorite"
export default class extends Controller {
  static targets = ["link", "card", "cacheCard", "popoverLink"]

  connect() {
    if (this.hasPopoverLinkTarget) {
      this.popover = new bootstrap.Popover(this.popoverLinkTarget);
      var a = document.createElement('a');
      var linkText = document.createTextNode("Go to my collection");
      a.appendChild(linkText);
      a.title = "Go to my collection";
      a.href = "/caches/favorites";
      this.popover.setContent(a);
    }
  }

  toggleIconFill() {
    // console.log(this.linkTarget);
    // this.linkTarget.className == 'fa-solid fa-heart-circle-minus fa-2xl' ? 'fa-solid fa-heart-circle-plus fa-2xl' : 'fa-solid fa-heart-circle-minus fa-2xl';
    ['fa-heart-circle-plus', 'fa-heart-circle-minus'].map(v=> this.linkTarget.classList.toggle(v) )

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
    if (this.linkTarget.classList.contains("fa-heart-circle-plus")) {
      this.popover.hide();
    } else if (this.linkTarget.classList.contains("fa-heart-circle-minus")) {
      this.popover.show();
    }
  }

  removeCacheCard() {
    // console.log(this.cacheCardTarget);
    this.cacheCardTarget.classList.add('d-none')
  }
}
