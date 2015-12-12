require 'rails_helper'

RSpec.describe Booking, type: :model do


  describe 'database columns' do
    it { should have_db_column :date }
    it { should have_db_column :status }
    it { should have_db_column :customer_id}
    it { should have_db_column :table_id}
    it { should have_db_column :reject_reason}
    it { should have_db_column :user_id}
  end
end
