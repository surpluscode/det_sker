require 'spec_helper'

describe LocationsController do

  describe 'GET#index' do
    it 'creates an array of locations' do
      location = FactoryGirl.create(:other_location)
      get :index
      expect(assigns(:locations)).to include(location)
    end
  end

  describe 'GET#show' do
    it 'assigns the correct location' do
      l = FactoryGirl.create(:other_location)
      get :show, id: l
      expect(assigns(:location)).to eq l
    end
  end

  describe 'show RSS' do
    render_views
    it 'renders correct xml' do
      l = FactoryGirl.create(:other_location)
      l.events << FactoryGirl.create(:event)
      get :show, id: l, format: 'rss'
      expect {
        Nokogiri::XML(response.body) { |config| config.strict }
      }.not_to raise_error
    end
  end

  describe 'POST#create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    it 'should create a location' do
      expect {
        post :create, location: FactoryGirl.attributes_for(:location)
      }.to change(Location, :count).by(1)
    end
  end

  describe 'PUT#update' do
    before :each do
      @location = FactoryGirl.create(:location)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    it 'should assign the correct location' do
      put :update, id: @location, location: FactoryGirl.attributes_for(:location)
      expect(assigns(:location).id).to eq @location.id
    end

    it 'should update the location' do
      l_mod = FactoryGirl.attributes_for(:location, description: 'A new description')
      put :update, id: @location, location: l_mod
      @location.reload
      expect(@location.description).to eq('A new description')
    end
  end

  describe 'DELETE#destroy' do
    before :each do
      @location = FactoryGirl.create(:location)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it 'deletes the location' do
      expect {
        delete :destroy, id: @location
      }.to change(Location, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, id: @location
      expect(response).to redirect_to locations_url
    end
  end
end

