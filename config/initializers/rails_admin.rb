RailsAdmin.config do |config|
  config.asset_source = :importmap

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.parent_controller = "::Admin::ActionController"

  config.authorize_with :cancancan

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

    member :view do
      link_icon do "fa fa-globe" end
      visible do
        [
          "LabourMarket::Agreement",
          "LabourMarket::Organisation"
        ].include?(bindings[:abstract_model].model.name)
      end
      controller do
        proc do
          if @object.is_a?(LabourMarket::Agreement)
            redirect_to "/collective-agreements/#{@object.slug}"
          elsif @object.is_a?(LabourMarket::Organisation)
            redirect_to "/unions/#{@object.slug}"
          end
        end
      end
    end

    member :user_account_grant_all_roles do
      link_icon do "fa fa-person" end
      visible do
        bindings[:abstract_model].model.name == "User::Account"
      end
      controller do
        proc do
          User::GrantAllRolesToUserJob.perform_later(@object.id)
          redirect_to "/admin/user~account/#{@object.id}"
        end
      end
    end

    member :user_role_grant_to_everyone do
      link_icon do "fa fa-person" end
      visible do
        bindings[:abstract_model].model.name == "User::Role"
      end
      controller do
        proc do
          User::GrantRoleToEveryoneJob.perform_later(@object.id)
          redirect_to "/admin/user~role/#{@object.id}"
        end
      end
    end

    member :add_2023 do
      link_icon do "fa fa-plus" end
      visible do
        bindings[:abstract_model].model.name == "LabourMarket::Agreement"
      end
      controller do
        proc do
          version = @object.versions.create(
            signing_year: "2023",
            expiry_year: "2025",
          )
          redirect_to "/admin/labour_market~agreement_version/#{version.id}"
        end
      end
    end
  end

  module RailsAdmin
    module Config
      module Fields
        module Types
          class EditorJsField < RailsAdmin::Config::Fields::Base
            RailsAdmin::Config::Fields::Types::register(self)

            def partial
              :form_editorjs
            end
          end
        end
      end
    end
  end


  RailsAdmin::Config::Fields::Types.register(:editorjs, RailsAdmin::Config::Fields::Types::EditorJsField)
end
