require 'spec_helper'

describe AdminController do

  describe 'dashboard' do
    context 'when admin user' do
      before do
        admin = FactoryGirl.create(:admin_user)
        sign_in admin
        FactoryGirl.create(:event)
        FactoryGirl.create(:event_tomorrow)
        FactoryGirl.create(:event_yesterday)
        get :dashboard
      end
      it 'returns successfully' do
        expect(response.code).to eql '200'
      end

      it 'lists coming events' do
        expect(assigns(:events).size).to eql 2
      end

      it 'orders by created date descending' do
        first = assigns(:events).first
        last = assigns(:events).last
        puts first.created_at
        puts last.created_at
        expect(first.created_at).to be > last.created_at
      end

    end
    context 'when normal user' do
      before do
        normal = FactoryGirl.create(:user)
        sign_in normal
        get :dashboard
      end
      it 'returns forbidden' do
        expect(response.code).to eql '302'
      end
    end
    context 'when not logged in' do
      it 'returns unauthenticated' do
        get :dashboard
        expect(response.code).to eql '302'
      end
    end
  end
end