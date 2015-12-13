require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build_stubbed :order }

  it 'has a valid factory' do
    expect(order).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :table }
    it { is_expected.to validate_presence_of :user }
    it 'validates if user is waiter' do
      order.user = build(:user, :guest)
      expect(order).not_to be_valid
    end
  end
end
