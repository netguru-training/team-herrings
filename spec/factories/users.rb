# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  role                   :string           default("guest"), not null
#

FactoryGirl.define do
  factory :user do
    name "Test User"
    email { Faker::Internet.email }
    password "please123"
  end

  trait :admin do
    role User::ADMIN_ROLE
  end

  trait :waiter do
    role User::WAITER_ROLE
  end

  trait :guest do
    role User::GUEST_ROLE
  end
end
