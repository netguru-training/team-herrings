require 'rails_helper'

RSpec.describe Table, type: :model do
  let(:table) { build_stubbed :table }

  it 'has a valid factory' do
    expect(table).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :places }
    it { is_expected.to validate_presence_of :type }
    it { is_expected.to define_enum_for(:type).with([:indoor, :outdoor]) }

    context 'with invalid type' do
      it 'returns error' do
        expect { build_stubbed :table, type: :inside }
          .to raise_error(ArgumentError)
          .with_message(/is not a valid type/)
      end
    end
  end

  describe 'database columns' do
    it { should have_db_column :name }
    it { should have_db_column :places }
    it { should have_db_column :type }
  end
end
