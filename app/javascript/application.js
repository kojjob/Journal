// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"
import Flatpickr from "stimulus-flatpickr"

const application = Application.start()
application.register("flatpickr", Flatpickr)
