require 'rails_helper'

RSpec.describe Admin::DishesController do
  let(:user) { create :user, :admin }

  before { sign_in(user) }

  describe 'GET #show' do
    let(:dish) { create :dish }
    subject { get :show, id: dish.id }

    it_behaves_like 'template rendering action', :show
  end

  describe 'GET #index' do
    subject { get :index }

    it_behaves_like 'template rendering action', :index
  end

  describe 'GET #edit' do
    let(:dish) { create :dish }
    subject { get :show, id: dish.id }

    it_behaves_like 'template rendering action', :show
  end

  describe 'GET #new' do
    subject { get :new }

    it_behaves_like 'template rendering action', :new
  end

  describe 'POST #create' do
    let(:params) { { dish: build(:dish).attributes } }
    subject { post :create, params }

    context 'returns response with success' do
      it { is_expected.to redirect_to admin_dish_path(controller.dish) }

      it 'flashes info' do
        subject
        expect(flash[:notice]).to eq I18n.t('shared.created', resource: 'Dish')
      end

      it 'creates table' do
        expect{ subject }.to change(Dish, :count).by(1)
      end
    end

    context 'returns response with failure' do
      include_context 'record save failure'

      it_behaves_like 'template rendering action', :new
    end
  end

  describe 'PUT #update' do
    let!(:dish) { create :dish, name: 'Test dish', price: 20, weight: 200, vat: 23 }
    let(:params) do
      { id: dish.id, dish: { name: 'Final dish', price: 30, weight: 400, vat: 8 } }
    end
    subject { put :update, params }

    context 'when all parameters given' do
      it { is_expected.to redirect_to admin_dish_path(dish) }

      it 'flashes info' do
        subject
        expect(flash[:notice]).to eq I18n.t('shared.updated', resource: 'Dish')
      end

      it 'updates info' do
        subject
        expect(dish.reload.name).to eq('Final dish')
        expect(dish.price).to eq(30)
        expect(dish.weight).to eq(400)
        expect(dish.vat).to eq(8)
      end
    end

    context 'returns response with failure' do
      include_context 'record save failure'

      it_behaves_like 'template rendering action', :edit
    end
  end

  describe 'DELETE #destroy' do
    let!(:dish) { create :dish }
    subject { delete :destroy, id: dish.id }

    it { is_expected.to redirect_to admin_dishes_path }

    it 'flashes info' do
      subject
      expect(flash[:notice]).to eq I18n.t('shared.deleted', resource: 'Dish')
    end

    it 'destroys dish' do
      expect{ subject }.to change(Dish, :count).by(-1)
    end
  end
end
