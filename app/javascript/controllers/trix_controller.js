import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("trix-initialize", this.addPlaceholder.bind(this))
  }

  addPlaceholder(event) {
    const trix = event.target
    const placeholder = this.element.getAttribute("placeholder")
    const placeholderDiv = document.createElement("div")
    placeholderDiv.classList.add("trix-placeholder")
    placeholderDiv.textContent = placeholder
    trix.toolbarElement.insertAdjacentElement("afterend", placeholderDiv)
  }
}