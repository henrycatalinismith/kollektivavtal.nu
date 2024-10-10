Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
  resource :session
  resources :passwords, param: :token
  #resource :registration, only: %i[new create]
end
