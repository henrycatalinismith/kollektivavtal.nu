class User::Account < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :authorizations, class_name: 'User::Authorization', foreign_key: 'account_id'
  has_many :roles, through: :authorizations, class_name: 'User::Role', foreign_key: 'role_id'

  def role?(role)
    roles.exists?(name: role)
  end
end
