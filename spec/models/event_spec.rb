require 'spec_helper'

describe Event do
  before(:each) do
    @party_details = {title: 'Massive party', short_description: 'The Best Party Ever!',
                   start_time: DateTime.new, end_time: DateTime.new, location_id: '1',
                  user_id: '1'}
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
    @party_details.delete(:location_id)
    Event.create(@party_details).valid?.should_not be_true
  end
  it 'should not save an event without a short description' do
    @party_details.delete(:short_description)
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

  describe 'Event.current_events' do
    it 'should include number of comments for the event' do
      e = FactoryGirl.create(:event)
      c = FactoryGirl.create(:comment, event: e)
      events = Event.current_events
      events.should include e
      events.first.comments.first.should eql c
    end
  end

  describe 'Event.in_progress?' do
    it 'should return true when an event is in progress' do
      e = FactoryGirl.create(:event)
      e.in_progress?.should be_true
    end

    it 'should return false when an event has already finished' do
      e = FactoryGirl.create(:event_yesterday)
      e.in_progress?.should be_false
    end

    it 'should return false when an event has not started' do
      e = FactoryGirl.create(:event_tomorrow)
      e.in_progress?.should be_false
    end
  end

end
