require 'rails_helper'

RSpec.describe Admin::TablesController do
  let(:user) { create :user, :admin }

  before { sign_in(user) }

  describe 'GET #show' do
    let(:table) { create :table }
    subject { get :show, id: table.id }

    it_behaves_like 'template rendering action', :show
  end

  describe 'GET #index' do
    subject { get :index }

    it_behaves_like 'template rendering action', :index
  end

  describe 'GET #edit' do
    let(:table) { create :table }
    subject { get :show, id: table.id }

    it_behaves_like 'template rendering action', :show
  end

  describe 'GET #new' do
    subject { get :new }

    it_behaves_like 'template rendering action', :new
  end

  describe 'POST #create' do
    let!(:params) { { table: attributes_for(:table) } }
    subject { post :create, params }

    context 'returns response with success' do
      it { is_expected.to redirect_to admin_table_path(controller.table) }

      it 'flashes info' do
        subject
        expect(flash[:notice]).to eq I18n.t('shared.created', resource: 'Table')
      end

      it 'creates table' do
        expect{ subject }.to change(Table, :count).by(1)
      end
    end

    context 'returns response with failure' do
      include_context 'record save failure'

      it_behaves_like 'template rendering action', :new
    end
  end

  describe 'PUT #update' do
    let!(:table) { create :table, places: 6, location: :indoor }
    let(:places) { 5 }
    let(:location) { 'outdoor' }
    let!(:params) do
      { id: table.id, table: { places: places, location: location } }
    end
    subject { put :update, params }

    context 'returns response with success' do
      it { is_expected.to redirect_to admin_table_path(controller.table) }

      it 'flashes info' do
        subject
        expect(flash[:notice]).to eq I18n.t('shared.updated', resource: 'Table')
      end

      context 'updates table' do
        subject { -> { put :update, params } }
        it { is_expected.to change{ table.reload.places }.to(places) }
        it { is_expected.to change{ table.reload.location }.to(location) }
      end
    end

    context 'returns response with failure' do
      include_context 'record save failure'

      it_behaves_like 'template rendering action', :edit
    end
  end

  describe 'DELETE #destroy' do
    let!(:table) { create :table }
    subject { delete :destroy, id: table.id }

    it { is_expected.to redirect_to admin_tables_path }

    it 'flashes info' do
      subject
      expect(flash[:notice]).to eq I18n.t('shared.deleted', resource: 'Table')
    end

    it 'destroys table' do
      expect{ subject }.to change(Table, :count).by(-1)
    end
  end
end
