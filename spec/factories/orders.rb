FactoryGirl.define do
  factory :order do
    user { create(:user, :waiter) }
    dishs { create_list(:dish, 5) }
    table { create(:table) }
  end
end
