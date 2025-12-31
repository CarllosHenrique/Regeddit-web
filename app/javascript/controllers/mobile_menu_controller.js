import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "backdrop"]

  toggle() {
    this.menuTarget.classList.toggle("hidden")
    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.toggle("hidden")
    }
  }

  close() {
    this.menuTarget.classList.add("hidden")
    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.add("hidden")
    }
  }
}
