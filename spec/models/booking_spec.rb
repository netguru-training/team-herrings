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
  describe 'database columns' do
    it { should have_db_column :date }
    it { should have_db_column :status }
    it { should have_db_column :table_id }
    it { should have_db_column :reject_reason }
    it { should have_db_column :user_id }
  end

  describe 'scopes' do
    let(:pending_booking) { create :booking, :pending }
    subject(:bookings) { described_class.pending }

    it 'returns only pending bookings' do
      expect(bookings).to include(pending_booking)
    end
  end
end
