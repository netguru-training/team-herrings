require 'rails_helper'

RSpec.describe DishesController do
  describe 'GET #index' do
    subject { get :index }

    it_behaves_like 'template rendering action', :index
  end
end
