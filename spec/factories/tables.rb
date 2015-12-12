# == Schema Information
#
# Table name: tables
#
#  id         :integer          not null, primary key
#  places     :integer
#  location   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :table do
    places { Faker::Number.between(2, 6) }
    location { Table.locations.keys.sample }

    trait :indoor do
      location :indoor
    end

    trait :outdoor do
      location :outdoor
    end
  end
end
