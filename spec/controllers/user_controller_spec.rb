require 'spec_helper'

describe UserController do

  describe 'get#index' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should return a list of all users' do
      get :index
      assigns(:users).should_not be_nil
      assigns(:users).first.should be_a User
    end
  end

  describe 'get#show/:id' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should assign the requested user to the session' do
      get :show, id: @user
      assigns(:user).should eql @user
    end
  end

  describe 'get#edit/:id' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should not permit normal users to edit' do
      get :edit, id: @user
      response.should redirect_to new_user_session_path
    end

    it 'should permit admin users to edit' do
      pending
    end

    it 'should permit the user themself to edit' do
      pending
    end

  end

  describe 'post#update/:id' do
    it 'should not permit normal users to update' do
      pending
    end

    it 'should permit admin users to update' do
      pending
    end


    it 'should permit the user themself to update their profile' do
      pending
    end

  end

  describe 'patch#make_admin' do
    it 'should make the specified user an admin user' do
      pending
    end

  end
end