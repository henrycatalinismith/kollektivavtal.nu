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

  get "/labour-market" => "labour_market#index", as: :labour_market
  get "/labour-market/collective-agreements" => "labour_market/agreements#index", as: :collective_agreements
  get "/labour-market/collective-agreements/:agreement" => "labour_market/agreements#show", as: :collective_agreement

  get "/labour-market/central-unions" => "labour_market/organisations#index",
    as: :central_unions,
    defaults: { organisation_type: :central_union }
  get "/labour-market/central-unions/:organisation" => "labour_market/organisations#show",
    as: :central_union,
    defaults: { organisation_type: :central_union }

  get "/labour-market/employer-associations" => "labour_market/organisations#index",
    as: :employer_associations,
    defaults: { organisation_type: :employer_association }
  get "/labour-market/employer-associations/:organisation" => "labour_market/organisations#show",
    as: :employer_association,
    defaults: { organisation_type: :employer_association }

  get "/labour-market/local-unions" => "labour_market/organisations#index",
    as: :local_unions,
    defaults: { organisation_type: :local_union }
  get "/labour-market/local-unions/:organisation" => "labour_market/organisations#show",
    as: :local_union,
    defaults: { organisation_type: :local_union }

  # get "/labour-market/collective-agreements/:agreement/:version" => "labour_market/collective_agreement_versions#show", as: :collective_agreement_version
end
