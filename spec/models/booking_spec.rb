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
    it { should have_db_column :number }
  end

  describe 'validations' do
    before { Booking.skip_callback(:validation, :before, :generate_number) }

    context 'without a number' do
      subject { build_stubbed(:booking, number: nil) }
      it { is_expected.to_not be_valid}
    end

    context 'with number that is not unique' do
      let!(:booking) { create :booking }
      subject { build_stubbed :booking }
      it { is_expected.to_not be_valid }
    end

    context 'when number length different than 6' do
      subject { build_stubbed :booking, number: '12345' }
      it { is_expected.to_not be_valid }
    end

    context 'with number not numerical' do
      subject { build_stubbed :booking, number: 'abcdef' }
      it { is_expected.to_not be_valid }
    end

    context 'when status is set to rejected' do
      context 'with no reject reason' do
        subject { build_stubbed :booking, status: described_class.statuses[:rejected], reject_reason: nil }
        it { is_expected.to_not be_valid }
      end
    end

    after { Booking.set_callback(:validation, :before, :generate_number) }
  end

  describe 'scopes' do
    describe '.with_status' do
      let(:pending_booking) { create :booking, :pending }
      let(:accepted_booking) { create :booking, :accepted }

      context 'with existing status' do
        subject(:bookings) { described_class.with_status('pending') }

        it 'returns only bookings with that status' do
          expect(bookings).to include(pending_booking)
          expect(bookings).to_not include(accepted_booking)
        end
      end

      context 'with non-existing status' do
        subject(:bookings) { described_class.with_status('waiting') }

        it 'returns no bookings' do
          expect(bookings.count).to eq 0
        end
      end
    end
  end
end
