FactoryGirl.define do
  factory :table do
    places { Faker::Number.between(2, 6) }
    type { Table.types.keys.sample }

    trait :indoor do
      type :indoor
    end

    trait :outdoor do
      type :outdoor
    end
  end
end
