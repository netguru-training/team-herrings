# == Schema Information
#
# Table name: bookings
#
#  id            :integer          not null, primary key
#  date          :datetime
#  status        :integer          default(0)
#  reject_reason :string
#  table_id      :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:booking) { create :booking }

  it 'has a valid factory' do
    expect(booking).to be_valid
  end

  describe 'database columns' do
    it { should have_db_column :date }
    it { should have_db_column :status }
    it { should have_db_column :table_id }
    it { should have_db_column :reject_reason }
    it { should have_db_column :user_id }
  end

  describe 'scopes' do
    describe '.with_status' do
      let(:pending_booking) { create :booking, :pending }
      subject(:bookings) { described_class.with_status('pending') }

      it 'returns only pending bookings' do
        expect(bookings).to include(pending_booking)
      end
    end
  end
end
