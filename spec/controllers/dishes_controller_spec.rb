require 'rails_helper'

RSpec.describe DishesController do
  let(:dish) { create :dish }

  describe 'GET #index' do
    subject { get :index }

    it_behaves_like 'template rendering action', :index
  end
end
