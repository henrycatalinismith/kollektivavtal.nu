# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    # return unless user.admin?
    can :access, :rails_admin
    can :manage, :dashboard
    can :manage, Blog::Post
    can :manage, User::Account
    can :manage, MailingList::Subscription
  end
end
