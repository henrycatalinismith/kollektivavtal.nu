RailsAdmin.config do |config|
  config.asset_source = :importmap

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.parent_controller = "::AdminActionController"

  config.authorize_with :cancancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model "User::Account" do
    object_label_method do
      :email
    end
  end

  config.model "Blog::Post" do
    configure :body_en, :text
    configure :body_sv, :text
  end
end
