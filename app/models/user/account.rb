class User::Account < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :authorizations, class_name: "User::Authorization", foreign_key: "account_id"
  has_many :roles, through: :authorizations, class_name: "User::Role", foreign_key: "role_id"

  rails_admin do
    list do
      field :email
      field :roles
      field :created_at
      field :updated_at
      sort_by :created_at
    end

    object_label_method do
      :email
    end
  end

  def role?(role)
    roles.exists?(name: role)
  end
end
