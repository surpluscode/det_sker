require 'spec_helper'

describe 'Events to Categories relationship' do

  it 'should maintain associations between events and categories' do
    event = FactoryGirl.create(:event)
    category = FactoryGirl.create(:demo_cat, english: Time.now.to_i)
    event.categories << category
    event.categories.count.should eql 1
    category.events.count.should eql 1
  end
end