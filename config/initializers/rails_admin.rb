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
    list do
      configure :email do
        sticky true
        column_width 256
      end
    end

    object_label_method do
      :email
    end
  end

  config.model "User::Authorization" do
    list do
      configure :account do
        sticky true
        column_width 256
      end

      configure :role do
        sticky true
        column_width 256
      end
    end
  end

  config.model "User::Role" do
    list do
      configure :name do
        sticky true
        column_width 256
      end
    end
  end

  config.model "Blog::Post" do
    configure :body_en, :text
    configure :body_sv, :text

    configure :title_en do
      sticky true
      column_width 256
    end
  end

  config.model "MailingList::Subscription" do
    configure :email do
      sticky true
      column_width 256
    end
    configure :sendgrid_status do
      sticky true
    end
    configure :turnstile_status do
      sticky true
    end
  end
end
