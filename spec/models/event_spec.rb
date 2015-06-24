require 'spec_helper'

describe Event do
  before(:each) do
    @party_details = {
        title: 'Massive party', short_description: 'The Best Party Ever!',
        start_time: DateTime.new, end_time: DateTime.new, location_id: '1',
        user_id: '1', categories: [Category.create(danish: 'ost', english: 'cheese')]
    }
  end
  it 'should create an event' do
    event = Event.create(@party_details)
    expect(event.valid?).to be_true
    expect(event.title).to match('Massive party')
  end
  it 'should not save an event without a title' do
    @party_details.delete(:title)
    expect(Event.create(@party_details).valid?).not_to be_true
  end
  it 'should not save an event without a location' do
    @party_details.delete(:location_id)
    expect(Event.create(@party_details).valid?).not_to be_true
  end
  it 'should not save an event without a short description' do
    @party_details.delete(:short_description)
    expect(Event.create(@party_details).valid?).not_to be_true
  end

  it 'should not save an event without a start_time' do
    @party_details.delete(:start_time)
    expect(Event.create(@party_details).valid?).not_to be_true
  end

  it 'should not save an event without an end_time' do
    @party_details.delete(:end_time)
    expect(Event.create(@party_details).valid?).not_to be_true
  end

  describe 'Event.in_progress?' do
    it 'should return true when an event is in progress' do
      e = FactoryGirl.create(:event)
      expect(e.in_progress?).to be_true
    end

    it 'should return false when an event has already finished' do
      e = FactoryGirl.create(:event_yesterday)
      expect(e.in_progress?).to be_false
    end

    it 'should return false when an event has not started' do
      e = FactoryGirl.create(:event_tomorrow)
      expect(e.in_progress?).to be_false
    end
  end

  it 'should sort by start time ascending' do
    today = FactoryGirl.create(:event)
    tomorrow = FactoryGirl.create(:event_tomorrow)
    expect([tomorrow, today].sort.first).to eql today
  end

  it 'has a link field' do
    e = Event.new
    e.link = 'http://example.com'
    expect(e.link).to eql 'http://example.com'
  end

end
