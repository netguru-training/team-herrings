require 'rails_helper'

RSpec.describe BookingsController do
  describe 'GET #new' do
    subject { get :new }

    it_behaves_like 'template rendering action', :new
  end

  describe 'PUT #create' do
    let(:params) { attributes_for(:booking) }
    subject { post :create, booking: params }

    context 'when no user signed in' do
      context 'when no password for new user given' do
        it { is_expected.to redirect_to(root_path) }

        it 'creates new Booking' do
          expect { subject }.to change(Booking, :count).by(1)
        end
      end
    end

    context 'when existing user signed in' do
      let(:user) { create(:user) }
      before { sign_in(user) }

      it { is_expected.to redirect_to(Booking.last) }

      it 'creates new Booking' do
        expect { subject }.to change(Booking, :count).by(1)
      end
    end
  end

  describe 'GET #index' do
    subject { get :index }

    context 'when existing user signed in' do
      let(:user) { create(:user) }
      before { sign_in(user) }

      it_behaves_like 'template rendering action', :index
    end

    context 'when no user signed in' do
      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  describe 'GET #show' do
    let(:booking) { create(:booking) }
    subject { get :show, id: booking.id }

    context 'when creator of booking signed in' do
      before { sign_in(booking.user) }

      it_behaves_like 'template rendering action', :show
    end

    context 'when no user signed in' do
      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
end
