class User::GrantRoleToEveryoneJob < ApplicationJob
  queue_as :default

  def perform(role_id)
    role = User::Role.find(role_id)
    accounts = User::Account.all
    accounts.each do |account|
      account.authorizations.create(role: role)
    end
  end
end
