FactoryGirl.define do
  factory :dish do
    name { Faker::Hipster.words }
    weight { Faker::Number.between(2, 3) }
    vat { Faker::Number.between(1, 2) }
    price { Faker::Number.decimal(2) }
  end
end
