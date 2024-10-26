# require "pagy/extras/bootstrap"
# require "pagy/extras/navs"

# # Load the pagy frontend assets
# require "pagy/extras/assets"

Pagy::DEFAULT[:items] = 15  # Set the default number of items per page
Pagy::DEFAULT[:size]  = 7   # Set the number of page links to show (use an odd number for better centering)
