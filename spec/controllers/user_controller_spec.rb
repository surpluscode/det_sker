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

    it 'should not permit non-logged in users to edit' do
      get :edit, id: @user
      response.should redirect_to new_user_session_path
    end

    it 'should not permit normal users to edit other users' do
      diff_user = FactoryGirl.create(:different_user)
      sign_in diff_user
      get :edit, id: @user
      response.should redirect_to users_path
    end

    it 'should permit admin users to edit' do
      admin = FactoryGirl.create(:admin_user)
      sign_in admin
      get :edit, id: @user
      response.should render_template :edit
    end

    it 'should permit a logged in user to edit their own profile' do
      sign_in @user
      get :edit, id: @user
      response.should render_template :edit
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