require 'spec_helper'

describe CommentsController do

  describe 'POST#Create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @event = FactoryGirl.create(:event)
    end

    it 'should create a comment object when sent valid parameters' do
        expect {
          post :create, comment: FactoryGirl.attributes_for(:comment, event_id: @event.id)
        }.to change(Comment, :count).by(1)
    end

    it 'should not create a comment object without an associated event' do
      expect {
        post :create, comment: FactoryGirl.attributes_for(:comment)
      }.to_not change(Comment, :count).by(1)
    end

    it 'should not create a comment object without a logged in user' do
      sign_out @user
      expect {
        post :create, comment: FactoryGirl.attributes_for(:comment, event_id: @event.id)
      }.to_not change(Comment, :count).by(1)
    end
  end

end
