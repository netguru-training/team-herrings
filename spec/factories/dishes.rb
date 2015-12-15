# == Schema Information
#
# Table name: dishes
#
#  id         :integer          not null, primary key
#  name       :string
#  vat        :integer
#  weight     :integer
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :dish do
    name { Faker::Hipster.word }
    weight { Faker::Number.between(2, 3) }
    vat { Faker::Number.between(1, 2) }
    price { Faker::Number.decimal(2) }
    category
  end
end
