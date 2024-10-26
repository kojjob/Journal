// app/javascript/controllers/flash_messages_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    this.messageTargets.forEach(message => {
      this.animateIn(message)
      setTimeout(() => this.dismissFlash({ target: message }), 5000)
    })
  }

  dismissFlash(event) {
    const message = event.target.closest('.flash-message')
    this.animateOut(message)
  }

  animateIn(element) {
    element.classList.remove(element.dataset.transitionEnterStart)
    element.classList.add(element.dataset.transitionEnterEnd)
  }

  animateOut(element) {
    element.classList.remove(element.dataset.transitionLeaveStart)
    element.classList.add(element.dataset.transitionLeaveEnd)
    setTimeout(() => element.remove(), 300)
  }
}