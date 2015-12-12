# == Schema Information
#
# Table name: tables
#
#  id         :integer          not null, primary key
#  places     :integer
#  location   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Table, type: :model do
  let(:table) { build_stubbed :table }

  it 'has a valid factory' do
    expect(table).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :places }
    it { is_expected.to validate_presence_of :location }
    it { is_expected.to define_enum_for(:location).with([:indoor, :outdoor]) }

    context 'with invalid location' do
      it 'returns error' do
        expect { build_stubbed :table, location: :inside }
          .to raise_error(ArgumentError)
          .with_message(/is not a valid location/)
      end
    end
  end

  describe 'database columns' do
    it { should have_db_column :places }
    it { should have_db_column :location }
  end
end
