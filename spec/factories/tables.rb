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
