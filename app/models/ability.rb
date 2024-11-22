# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    return unless user.role?("admin")
    can :access, :rails_admin
    can :manage, :dashboard

    if user.role?("blog_admin")
      can :manage, Blog::Post
    end

    if user.role?("user_admin")
      can :manage, User::Account
      can :manage, User::Authorization
      can :manage, User::Role
    end

    if user.role?("media_admin")
      can :manage, Media::Image
    end

    if user.role?("policy_admin")
      can :manage, Policy::Document
      can :manage, Policy::Revision
    end

    if user.role?("labour_market_admin")
      can :manage, LabourMarket::Agreement
      can :manage, LabourMarket::AgreementMembership
      can :manage, LabourMarket::AgreementVersion
      can :manage, LabourMarket::Bookmark
      can :manage, LabourMarket::Document
      can :manage, LabourMarket::Organisation
      can :manage, LabourMarket::OrganisationMembership
    end

    if user.role?("social_media_admin")
      can :manage, SocialMedia::Account
    end
  end
end
