Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "home#index"
  post "contacts" => "contacts#create"
  get "up" => "rails/health#show", as: :rails_health_check
  resource :session
  resources :passwords, param: :token
  #resource :registration, only: %i[new create]

  devise_for :users, {
    class_name: "User::Account",
    controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions"
    },
    path: "",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      sign_up: "register",
      # password: "password"
    }
  }
end
