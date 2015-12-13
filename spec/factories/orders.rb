FactoryGirl.define do
  factory :order do
    user { create(:user, :waiter) }
    dishes { create_list(:dish, 5) }
    table { create(:table) }
    status { 'delivered' }
  end
end
