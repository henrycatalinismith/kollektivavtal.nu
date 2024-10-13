Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "home#index"
  post "contacts" => "contacts#create"
  get "up" => "rails/health#show", as: :rails_health_check
  resource :session
  resources :passwords, param: :token
  #resource :registration, only: %i[new create]
end
