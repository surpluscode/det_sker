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

    it 'should not allow anonymous users to leave comments' do
      sign_out @user
      sign_in FactoryGirl.create(:anonymous_user)

      expect {
        post :create, comment: FactoryGirl.attributes_for(:comment, event_id: @event.id)
      }.to_not change(Comment, :count).by(1)
    end
  end

  describe 'PATCH#Update' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @event = FactoryGirl.create(:event)
      @comment = FactoryGirl.create(:comment, event_id: @event.id)
    end

    it 'should allow a user to update their comment' do
      mod = FactoryGirl.attributes_for(:comment,
        content: 'Actually, I reconsider...', comment_id: @comment.id)
      patch :update, id: @comment, comment: mod
      @comment.reload
      @comment.content.should eql 'Actually, I reconsider...'
    end

    it "should not allow a user to update another user's comment" do
      pending 'needs to be implemented'
    end

    it "should allow an admin user to update another user's comment" do
      pending 'needs to be implemented'
    end

  end

end
