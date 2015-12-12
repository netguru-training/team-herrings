require 'rails_helper'

RSpec.describe Dish, type: :model do
  let(:dish) { build_stubbed :dish }

  it 'has a valid factory' do
    expect(dish).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'database columns' do
    it { should have_db_column :name }
    it { should have_db_column :weight }
    it { should have_db_column :vat }
    it { should have_db_column :price }
  end

  describe 'compute netto from price and vat' do
    let!(:dish) { create :dish, name: 'Pizza', weight: 100, vat: 23, price: 20.99 }
    it 'computes correct value' do
      expect(dish.netto_price).to eq 17.07
    end
  end


end
