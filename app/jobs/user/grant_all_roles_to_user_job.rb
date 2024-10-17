class User::GrantAllRolesToUserJob < ApplicationJob
  queue_as :default

  def perform(account_id)
    account = User::Account.find(account_id)
    roles = User::Role.all
    roles.each do |role|
      account.authorizations.create(role: role)
    end
  end
end
