import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]
  static values = { previewClass: String }

  handleFiles() {
    this.clearPreviews()
    Array.from(this.inputTarget.files).forEach(file => this.createPreview(file))
  }

  createPreview(file) {
    const reader = new FileReader()
    reader.onload = (e) => {
      const preview = document.createElement('div')
      preview.classList.add(...this.previewClassValue.split(' '))
      
      if (file.type.startsWith('image/')) {
        const img = document.createElement('img')
        img.src = e.target.result
        img.classList.add('h-20', 'w-20', 'object-cover', 'rounded-md')
        preview.appendChild(img)
      } else if (file.type.startsWith('video/')) {
        const video = document.createElement('video')
        video.src = e.target.result
        video.classList.add('h-20', 'w-20', 'object-cover', 'rounded-md')
        video.controls = true
        preview.appendChild(video)
      }

      const fileName = document.createElement('p')
      fileName.textContent = file.name
      fileName.classList.add('text-xs', 'mt-1', 'text-gray-500')
      preview.appendChild(fileName)

      this.previewTarget.appendChild(preview)
    }
    reader.readAsDataURL(file)
  }

  clearPreviews() {
    this.previewTarget.innerHTML = ''
  }
}