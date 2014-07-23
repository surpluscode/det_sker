require 'spec_helper'

describe 'Comment' do

  it 'should create a comment when given valid params' do
    u = FactoryGirl.create(:user)
    e = FactoryGirl.create(:event)
    comment = Comment.new(content: 'Sample comment', hidden: false, user: u, event: e)
    comment.save.should be_true
    comment.content.should eql 'Sample comment'
  end

  it 'should not create a comment without an associated event' do
    u = FactoryGirl.create(:user)
    comment = Comment.new(content: 'Sample comment', hidden: false, user: u)
    comment.save.should_not be_true
  end
end