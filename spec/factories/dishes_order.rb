FactoryGirl.define do
  factory :dishes_order do
    dish
    order
    count { Faker::Number.between(0, 10) }
  end
end
