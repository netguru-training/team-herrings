FactoryGirl.define do
  factory :order do
    user { create(:user, :waiter) }
    table { create(:table) }
    status { 'delivered' }
  end
end
