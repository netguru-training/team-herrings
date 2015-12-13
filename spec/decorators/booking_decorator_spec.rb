require 'spec_helper'

describe BookingDecorator do
  let(:booking) do
    create :booking,
           date: Time.zone.parse('2015-12-13 9:00:00 UTC'),
           status: :rejected,
           customer: Customer.new(first_name: 'John',
                                  last_name: 'Kowalsky',
                                  email: 'user@example.com')
  end

  describe 'reservation_date' do
    subject { booking.decorate.reservation_date }
    it { is_expected.to eq '13-12-15 09:00' }
  end
end
