require 'spec_helper'

describe 'Comment' do

  it 'should create a comment' do
    u = FactoryGirl.create(:user)
    e = FactoryGirl.create(:event)
    comment = Comment.new(content: 'Sample comment', hidden: false, user: u, event: e)
    comment.should be_a Comment
    comment.content.should eql 'Sample comment'
  end
end