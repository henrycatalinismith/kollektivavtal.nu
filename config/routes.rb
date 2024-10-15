Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "home#index"
  post "subscribe" => "mailing_list/subscriptions#create"
  get "up" => "rails/health#show", as: :rails_health_check

  get "created" => "mailing_list/subscriptions#created"

  devise_for :users, {
    class_name: "User::Account",
    controllers: {
      registrations: "user/registrations",
      sessions: "user/sessions"
    },
    path: "",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      sign_up: "register",
      # password: "password"
    }
  }

  constraints CanAccessFlipperUI do
    mount Flipper::UI.app(Flipper) => "/flipper"
  end
end
