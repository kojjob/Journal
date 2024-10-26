import Flatpickr from "stimulus-flatpickr"

// Import style for flatpickr
require("flatpickr/dist/flatpickr.css")

export default class extends Flatpickr {
  connect() {
    super.connect()
    console.log("Flatpickr connected")
  }
}