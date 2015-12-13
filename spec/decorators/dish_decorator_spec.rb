require 'rails_helper'

RSpec.describe DishDecorator do
  let(:dish) { create :dish, name: 'Pizza', weight: 100, vat: 23, price: 20.99 }

  describe 'vat_with_percent' do
    subject { dish.decorate.vat_with_percent }
    it { is_expected.to eq '23 %' }
  end

  describe 'price_with_currency' do
    subject { dish.decorate.price_with_currency }
    it 'return value with locale currency' do
      is_expected.to eq "20,99 zł"
    end
  end

  describe 'net_price_with_currency' do
    subject { dish.decorate.net_price_with_currency }
    it 'return value with locale currency' do
      is_expected.to eq '17,07 zł'
    end
  end

  describe 'weight_with_unit' do
    subject { dish.decorate.weight_with_unit }
    it { is_expected.to eq '100 g' }
  end
end
