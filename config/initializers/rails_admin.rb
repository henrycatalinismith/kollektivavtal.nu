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

    member :mailing_list_create_sendgrid_subscription_job do
      link_icon do "fa fa-envelope" end
      visible do
        bindings[:abstract_model].model.name == "MailingList::Subscription" and !bindings[:object].sendgrid_add_success?
      end
      controller do
        proc do
          MailingList::CreateSendgridSubscriptionJob.perform_later(@object.id)
          redirect_to "/admin/mailing_list~subscription/#{@object.id}"
        end
      end
    end

    member :mailing_list_delete_sendgrid_subscription_job do
      link_icon do "fa fa-envelope" end
      visible do
        bindings[:abstract_model].model.name == "MailingList::Subscription" and bindings[:object].sendgrid_add_success?
      end
      controller do
        proc do
          MailingList::DeleteSendgridSubscriptionJob.perform_later(@object.id)
          redirect_to "/admin/mailing_list~subscription/#{@object.id}"
        end
      end
    end

    member :mailing_list_preview_english_email do
      link_icon do "fa fa-eye" end
      visible do
        bindings[:abstract_model].model.name == "MailingList::Email"
      end
      controller do
        proc do
          render partial: "mailing_list/emails/html", locals: { email: @object, language: :en }
        end
      end
    end

    member :mailing_list_preview_swedish_email do
      link_icon do "fa fa-eye" end
      visible do
        bindings[:abstract_model].model.name == "MailingList::Email"
      end
      controller do
        proc do
          render partial: "mailing_list/emails/html", locals: { email: @object, language: :sv }
        end
      end
    end

    member :mailing_list_send_english_test_email_job do
      link_icon do "fa fa-envelope" end
      visible do
        bindings[:abstract_model].model.name == "MailingList::Email"
      end
      controller do
        proc do
          MailingList::SendTestEmailJob.perform_later(@object.id, :en)
          redirect_to "/admin/mailing_list~email/#{@object.id}"
        end
      end
    end

    member :mailing_list_send_swedish_test_email_job do
      link_icon do "fa fa-envelope" end
      visible do
        bindings[:abstract_model].model.name == "MailingList::Email"
      end
      controller do
        proc do
          MailingList::SendTestEmailJob.perform_later(@object.id, :sv)
          redirect_to "/admin/mailing_list~email/#{@object.id}"
        end
      end
    end

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

  config.model "Media::Image" do
    field :name, :string
    field :image, :active_storage do
      # pretty_value do
        # if value
          # bindings[:view].content_tag(:img, value.filename, src: value.url)
        # end
      # end
    end
  end

end
