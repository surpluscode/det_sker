require 'spec_helper'

describe 'Events to Categories relationship' do

  it 'should maintain associations between events and categories' do
    event = FactoryGirl.create(:event)
    category = FactoryGirl.create(:demo_cat, english: Time.now.to_i)
    event.categories << category
    expect(event.categories.count).to be > 1
    expect(category.events.count).to eql 1
  end
end