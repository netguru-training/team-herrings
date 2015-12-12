require 'rails_helper'

RSpec.describe TableDecorator do
  describe 'formatted_places' do
    context 'with 1 place' do
      let(:table) { create :table, places: 1}

      subject { table.decorate.formatted_places }
      it { is_expected.to eq '1 place' }
    end

    context 'with more than 1 place' do
      let(:table) { create :table, places: 4}

      subject { table.decorate.formatted_places }
      it { is_expected.to eq '4 places' }
    end
  end
end
