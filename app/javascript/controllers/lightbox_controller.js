import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "image"]

  open(event) {
    const imageUrl = event.currentTarget.querySelector('img').src
    this.imageTarget.src = imageUrl
    this.modalTarget.classList.remove('hidden')
  }

  close() {
    this.modalTarget.classList.add('hidden')
  }
}