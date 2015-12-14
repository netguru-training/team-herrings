# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  status     :string
#  table_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :order do
    user { create(:user, :waiter) }
    table { create(:table) }
    status { 'delivered' }
  end
end
