import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "trigger"]

  connect() {
    this.close()
  }

  toggle(event) {
    if (event) event.preventDefault()

    if (this.isOpen()) {
      this.close()
    } else {
      this.open()
    }
  }

  open() {
    if (!this.hasMenuTarget) return

    this.menuTarget.classList.remove("hidden")
    if (this.hasTriggerTarget) this.triggerTarget.setAttribute("aria-expanded", "true")
  }

  close() {
    if (!this.hasMenuTarget) return

    this.menuTarget.classList.add("hidden")
    if (this.hasTriggerTarget) this.triggerTarget.setAttribute("aria-expanded", "false")
  }

  click_outside(event) {
    if (!this.isOpen()) return
    if (this.element.contains(event.target)) return

    this.close()
  }

  isOpen() {
    return this.hasMenuTarget && !this.menuTarget.classList.contains("hidden")
  }
}
