require 'spec_helper'

describe UserController do

  describe 'get#index' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should return a list of all users' do
      get :index
      expect(assigns(:users)).not_to be_nil
      expect(assigns(:users).first).to be_a User
    end
  end

  describe 'get#show/:id' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should assign the requested user to the session' do
      get :show, id: @user
      expect(assigns(:user)).to eql @user
    end
  end

  describe 'get#edit/:id' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should not permit non-logged in users to edit' do
      get :edit, id: @user
      expect(response).to redirect_to page_path 'new_account'
    end

    it 'should not permit normal users to edit other users' do
      diff_user = FactoryGirl.create(:different_user)
      sign_in diff_user
      get :edit, id: @user
      expect(response).to redirect_to users_path
    end

    it 'should permit admin users to edit' do
      admin = FactoryGirl.create(:admin_user)
      sign_in admin
      get :edit, id: @user
      expect(response).to render_template :edit
    end

    it 'should permit a logged in user to edit their own profile' do
      sign_in @user
      get :edit, id: @user
      expect(response).to render_template :edit
    end

  end

  describe 'patch#make_admin' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should not permit non-admin users to make a user admin' do
      diff_user = FactoryGirl.create(:different_user)
      sign_in diff_user
      patch :make_admin, id: @user
      expect(response).to redirect_to users_path
    end

    it 'should allow admin users to make the relevant user an admin user' do
      admin = FactoryGirl.create(:admin_user)
      sign_in admin
      patch :make_admin, id: @user
      user = User.find(@user)
      expect(user.is_admin?).to be_true
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