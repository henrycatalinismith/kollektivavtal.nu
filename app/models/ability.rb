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

    if user.role?("mailing_list_admin")
      can :manage, MailingList::Subscription
    end
  end
end
