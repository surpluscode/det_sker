require 'spec_helper'

describe Event do
  before(:each) do
    @party_details = {title: 'Massive party', creator: 'FestAbe99', short_description: 'The Best Party Ever!',
                   location: 'ungdomshuset', start_time: DateTime.new, end_time: DateTime.new,
                   category: 'party', user_id: '1'}
  end
  it 'should create an event' do
    event = Event.create(@party_details)
    event.valid?.should be_true
    event.title.should match('Massive party')
  end
  it 'should not save an event without a title' do
    @party_details.delete(:title)
    Event.create(@party_details).valid?.should_not be_true
  end
  it 'should not save an event without a location' do
    @party_details.delete(:location)
    Event.create(@party_details).valid?.should_not be_true
  end
  it 'should not save an event without a short description' do
    @party_details.delete(:short_description)
    Event.create(@party_details).valid?.should_not be_true
  end
  it 'should not save an event without a category' do
    @party_details.delete(:category)
    Event.create(@party_details).valid?.should_not be_true
  end
  it 'should not save an event without a start_time' do
    @party_details.delete(:start_time)
    Event.create(@party_details).valid?.should_not be_true
  end

  it 'should not save an event without an end_time' do
    @party_details.delete(:end_time)
    Event.create(@party_details).valid?.should_not be_true
  end

  it 'should not save an event with an invalid category' do
    @party_details[:category] = 'Some nonsense category'
    Event.create(@party_details).valid?.should_not be_true
  end

  it 'should not save an event with an invalid location' do
    @party_details[:location] = 'Some invalid location'
    Event.create(@party_details).valid?.should_not be_true
  end

end
