Rails.application.routes.draw do
  resources :journals
  resources :categories, only: [ :show ]
  root "home#index"
  get "home/about"
  get "home/contact"

  get "up" => "rails/health#show", as: :rails_health_check
end
