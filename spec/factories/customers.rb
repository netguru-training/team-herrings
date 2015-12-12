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

FactoryGirl.define do
  factory :customer do
    first_name 'John'
    last_name 'Kowalski'
    email 'john.kowalski@company.com'
  end
end
