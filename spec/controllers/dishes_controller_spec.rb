require 'rails_helper'

RSpec.describe DishesController do
  let(:dish) { create :dish }
  let(:admin) { create :user, :admin }

  context 'no user is signed in' do
    describe 'GET #index' do
      subject { get :index }

      it_behaves_like 'template rendering action', :index
    end

    describe 'GET #show' do
      let(:dish) { create :dish }
      subject { get :show, id: dish.id }

      it_behaves_like 'template rendering action', :show
    end

    describe 'GET #edit' do
      subject { get :edit, id: dish.id }

      it 'redirects to new_user_session_path' do
        expect(subject).to redirect_to(new_user_session_path)
      end
    end
    describe 'GET #new' do
      subject { get :new }

      it 'redirects to new_user_session_path' do
        expect(subject).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      let!(:params) { { dish: build(:dish).attributes } }
      subject { post :create, params }

      it 'redirects to new_user_session_path' do
        expect(subject).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'admin is signed in' do
    before(:each) do
      sign_in(admin)
    end

    describe 'GET #edit' do
      let(:dish) { create :dish }
      subject { get :edit, id: dish.id }

      it_behaves_like 'template rendering action', :edit
    end

    describe 'GET #new' do
      subject { get :new }

      it_behaves_like 'template rendering action', :new
    end

    describe 'POST #create' do
      let!(:params) { { dish: build(:dish).attributes } }
      subject { post :create, params }

      context 'success' do
        it { is_expected.to redirect_to dish_path(controller.dish) }

        it 'flashes info' do
          subject
          expect(flash[:notice]).to eq I18n.t('shared.created', resource: 'Dish')
        end

        it 'creates dish' do
          expect { subject }.to change(Dish, :count).by(1)
        end
      end

      context 'failure' do
        include_context 'record save failure'

        it_behaves_like 'template rendering action', :new
      end


      describe 'PUT #update' do
        let!(:dish) { create :dish, name: 'Pizza', weight: 100, vat: 7, price: 10.99 }
        let(:name) { 'Meat' }
        let(:weight) { 50 }
        let(:vat) { 23 }
        let(:price) { 20.99 }
        let!(:params) do
          { id: dish.id, dish: { name: name, weight: weight, vat: vat, price: price } }
        end

        subject { put :update, params }

        context 'success' do
          it { is_expected.to redirect_to dish_path(controller.dish) }

          it 'flashes info' do
            subject
            expect(flash[:notice]).to eq I18n.t('shared.updated', resource: 'Dish')
          end

          context 'updates dish' do
            subject { -> { put :update, params } }
            it { is_expected.to change { dish.reload.name }.to(name) }
            it { is_expected.to change { dish.reload.weight }.to(weight) }
            it { is_expected.to change { dish.reload.vat }.to(vat) }
            it { is_expected.to change { dish.reload.price }.to(price) }
          end
        end

        context 'failure' do
          include_context 'record save failure'

          it_behaves_like 'template rendering action', :edit
        end
      end

      describe 'DELETE #destroy' do
        let!(:dish) { create :dish }
        subject { delete :destroy, id: dish.id }

        it { is_expected.to redirect_to dishes_path }

        it 'flashes info' do
          subject
          expect(flash[:notice]).to eq I18n.t('shared.deleted', resource: 'Dish')
        end

        it 'destroys dish' do
          expect { subject }.to change(Dish, :count).by(-1)
        end
      end
    end
  end
end
