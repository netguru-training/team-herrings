# == Schema Information
#
# Table name: bookings
#
#  id            :integer          not null, primary key
#  date          :datetime
#  status        :integer
#  reject_reason :string
#  table_id      :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :booking do
    date '2015-12-12 10:48:44'
    status 1
    reject_reason 'MyString'
    customer
    table
    user_id 1

    trait :pending do
      status :pending
    end
  end
end
