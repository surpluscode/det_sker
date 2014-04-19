require 'spec_helper'

describe Event do
  before(:each) do
    @party_details = {title: 'Massive party', creator: 'FestAbe99', description: 'The Best Party Ever!',
                   location: 'yourbackyard', start_time: DateTime.new, end_time: DateTime.new,
                   category: 'MadParty'}
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
  it 'should not save an event without a description' do
    @party_details.delete(:description)
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

end
