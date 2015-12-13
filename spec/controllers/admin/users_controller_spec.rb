require 'rails_helper'

RSpec.describe Admin::UsersController do
  let(:admin) { create :user, :admin }

  before { sign_in(admin) }

  describe 'GET #show' do
    let(:user) { create :user }
    subject { get :show, id: user.id }

    it_behaves_like 'template rendering action', :show
  end

  describe 'GET #index' do
    subject { get :index }

    it_behaves_like 'template rendering action', :index
  end

  describe 'GET #edit' do
    let(:user) { create :user }
    subject { get :show, id: user.id }

    it_behaves_like 'template rendering action', :show
  end

  describe 'GET #new' do
    subject { get :new }

    it_behaves_like 'template rendering action', :new
  end

  describe 'POST #create' do
    let!(:params) { { user: attributes_for(:user) } }
    subject { post :create, params }

    context 'returns response with success' do
      it { is_expected.to redirect_to admin_user_path(User.last) }

      it 'flashes notice' do
        subject
        expect(flash[:notice]).to eq I18n.t('shared.created', resource: 'User')
      end

      it 'creates user' do
        expect{ subject }.to change(User, :count).by(1)
      end
    end

    context 'returns response with failure' do
      include_context 'record save failure'

      it_behaves_like 'template rendering action', :new
    end
  end

  describe 'PUT #update' do
    let!(:user) { create :user }  
    let(:new_name) {'some other name'}
    let!(:params) do
      { id: user.id, user: { name: new_name} }
    end
    subject { put :update, params }

    context 'returns response with success' do
      it { is_expected.to redirect_to admin_user_path(user) }

      it 'flashes notice' do
        subject
        expect(flash[:notice]).to eq I18n.t('shared.updated', resource: 'User')
      end

      context 'updates user' do
        subject { -> { put :update, params } }
        it { is_expected.to change { user.reload.name }.to(new_name) }
      end
    end

    context 'returns response with failure' do
      include_context 'record save failure'

      it_behaves_like 'template rendering action', :edit
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    subject { delete :destroy, id: user.id }

    it { is_expected.to redirect_to admin_users_path }

    it 'flashes notice' do
      subject
      expect(flash[:notice]).to eq I18n.t('shared.deleted', resource: 'User')
    end

    it 'destroys user' do
      expect { subject }.to change(User, :count).by(-1)
    end
  end
end
