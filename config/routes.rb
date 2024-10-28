Rails.application.routes.draw do
  get "pages/show"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  root "home#index"
  get "/landing" => "home#landing"
  get "/subscribed" => "mailing_list/subscriptions#created"

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

  get "/news/" => "blog/posts#index", as: :blog_posts
  get "/news/:slug/" => "blog/posts#show", as: :blog_post

  get "/policies/:slug/" => "policy/documents#show", as: :policy_document
  get "/agreements/public-service/" => "agreements/documents#show", as: :agreement_document
  get "/opinion/unions-are-good-actually" => "magazine/documents#show", as: :magazine_document
end
