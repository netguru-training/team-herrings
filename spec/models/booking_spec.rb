# == Schema Information
#
# Table name: bookings
#
#  id            :integer          not null, primary key
#  date          :datetime
#  status        :integer
#  reject_reason :string
#  customer_id   :integer
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
    it { should have_db_column :customer_id }
    it { should have_db_column :table_id }
    it { should have_db_column :reject_reason }
    it { should have_db_column :user_id }
  end
end
