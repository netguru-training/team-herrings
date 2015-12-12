FactoryGirl.define do
  factory :table do
    name "Table with 2 places by the window"
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
