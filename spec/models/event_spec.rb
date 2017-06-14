require 'spec_helper'

describe Event do
  before(:each) do
    @party_details = {
        title: 'Massive party', short_description: 'The Best Party Ever!',
        start_time: DateTime.new, end_time: DateTime.new + 10.minutes, location_id: '1',
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

  it 'should not save an event with an end time before the start time' do
    mixed_up = Event.new(@party_details.merge(start_time: DateTime.now, end_time: DateTime.now - 1.hour))
    expect(mixed_up).not_to be_valid
  end

  it 'should not save a new event with a start time in the past' do
    past_event = Event.new(@party_details.merge(start_time: DateTime.now - 1.day, end_time: DateTime.now - 23.hours))
    expect(past_event).not_to be_valid
  end

  it 'should allow editing an event that was in the past' do
    mixed_up = Event.new(@party_details.merge(start_time: DateTime.now - 1.day, end_time: DateTime.now - 23.hours))
    mixed_up.save!(validate: false)
    expect { mixed_up.update!(title: 'A different title')}.to_not raise_error
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

  describe 'highlights' do
    before do
      @featured_event = FactoryGirl.create(:featured_event, start_time: DateTime.now + 40.minutes)
      FactoryGirl.create(:event_tomorrow)
      FactoryGirl.create(:event, start_time: DateTime.now + 23.minutes)
      FactoryGirl.create(:event, start_time: DateTime.now + 20.minutes)
      @past_event = FactoryGirl.create(:event_yesterday)
      @unpublished = FactoryGirl.create(:unpublished_event)
    end
    subject { Event.highlights(5) }
    it 'sorts by start time' do
      expect(subject.first.start_time).to be < subject.second.start_time
    end
    it 'does not contain duplicates' do
      expect(subject.size).to eql subject.uniq.size
    end
    it { should_not include @past_event }
    it { should_not include @unpublished_event }
    it { should include @featured_event }
  end
end
