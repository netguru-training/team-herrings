require 'rails_helper'

RSpec.describe Admin::BookingsController do
  let!(:admin) { create :user, :admin }
  let!(:user) { create :user }
  let!(:booking) { create :booking }

  describe 'GET #show' do
    subject { get :show, id: booking.id }

    context 'when signed in user is admin' do
      before { sign_in(admin) }
      it_behaves_like 'template rendering action', :show
    end

    context 'when signed in user is not admin' do
      before { sign_in(user) }
      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe 'GET #index' do
    context 'when signed in user is admin' do
      before { sign_in(admin) }
      let(:pending_booking) { create :booking, :pending }
      let(:accepted_booking) { create :booking, :accepted }

      context 'without status param' do
        subject { get :index }

        it { is_expected.to be_success }
        it_behaves_like 'template rendering action', :index
      end

      context 'with status param present' do
        subject { get :index, status: :pending }

        it { is_expected.to be_success }
        it_behaves_like 'template rendering action', :index
      end
    end

    context 'when signed in user is not admin' do
      before { sign_in(user) }
      subject { get :index }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe 'GET #edit' do
    subject { get :edit, id: booking.id }

    context 'when signed in user is admin' do
      before { sign_in(admin) }
      it_behaves_like 'template rendering action', :edit
    end

    context 'when signed in user is not admin' do
      before { sign_in(user) }
      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe 'GET #new' do
    subject { get :new }

    context 'when signed in user is admin' do
      before { sign_in(admin) }
      it_behaves_like 'template rendering action', :new
    end

    context 'when signed in user is not admin' do
      before { sign_in(user) }
      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe 'POST #create' do
    let!(:params) { { booking: attributes_for(:booking) } }
    subject { post :create, params }

    context 'when signed in user is admin' do
      before { sign_in(admin) }

      it { is_expected.to redirect_to admin_booking_path(controller.booking) }

      it 'flashes info' do
        subject
        expect(flash[:notice])
          .to eq I18n.t('shared.created', resource: 'Booking')
      end

      it 'creates booking' do
        expect { subject }.to change(Booking, :count).by(1)
      end

      context 'returns response with failure' do
        include_context 'record save failure'

        it_behaves_like 'template rendering action', :new
      end
    end

    context 'when signed in user is not admin' do
      before { sign_in(user) }
      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe 'PUT #update' do
    let!(:booking) { create :booking, date: '2015-12-12 10:48:44', status: :pending }
    let!(:params) { { id: booking.id, booking: { date: '2015-12-14 11:48:44', status: :accepted } } }
    subject { put :update, params }

    context 'when signed in user is admin' do
      before { sign_in(admin) }

      it 'flashes info' do
        subject
        expect(flash[:notice]).to eq I18n.t('shared.updated', resource: 'Booking')
      end

      context 'updates booking' do
        subject { -> { put :update, params } }
        it { is_expected.to change { booking.reload.date }.to('2015-12-14 11:48:44'.to_datetime) }
        it { is_expected.to change { booking.reload.status }.to('accepted') }
      end

      it { is_expected.to redirect_to admin_booking_path(controller.booking) }

      context 'returns response with failure' do
        include_context 'record save failure'

        it_behaves_like 'template rendering action', :edit
      end
    end

    context 'when signed in user is not admin' do
      before { sign_in(user) }
      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe 'PATCH #accept' do
    let!(:booking) { create :booking, :pending }
    let!(:params) { attributes_for(:booking) }
    subject { patch :accept, id: booking.id, booking: params }

    context 'when signed in user is admin' do
      before { sign_in(admin) }

      context 'sets booking status to accepted' do
        subject { -> { patch :accept, id: booking.id, booking: params } }

        it { is_expected.to change { booking.reload.status }.to('accepted') }

        it 'sends email notification' do
          expect(subject).to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      it { is_expected.to redirect_to admin_bookings_path }

      it 'flashes info' do
        subject
        expect(flash[:notice]).to eq I18n.t('booking.accepted', date: booking.decorate.reservation_date)
      end
    end

    context 'when signed in user is not admin' do
      before { sign_in(user) }
      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe 'PATCH #reject' do
    let!(:booking) { create :booking, :pending }
    let!(:params) { { reject_reason: 'some reason' } }
    subject { patch :reject, id: booking.id, booking: params }

    context 'when signed in user is admin' do
      before { sign_in(admin) }

      context 'sets booking status to rejected' do
        subject { -> { patch :reject, id: booking.id, booking: params } }

        it { is_expected.to change { booking.reload.status }.to('rejected') }

        it 'sends email notification' do
          expect(subject).to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      it { is_expected.to redirect_to admin_bookings_path }

      it 'flashes info' do
        subject
        expect(flash[:notice]).to eq I18n.t('booking.rejected', date: booking.decorate.reservation_date)
      end
    end

    context 'when signed in user is not admin' do
      before { sign_in(user) }
      it { is_expected.to redirect_to(root_path) }
    end
  end
end
