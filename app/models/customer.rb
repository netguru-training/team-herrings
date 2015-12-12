class Customer < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, format: Devise.email_regexp
end
