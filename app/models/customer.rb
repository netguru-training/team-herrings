# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  booking_id :integer
#

class Customer < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, format: Devise.email_regexp

  belongs_to :booking
end
