require 'spec_helper'

describe Day do
  before :each do
    @event = FactoryGirl.create(:event)
    @day = Day.new(@event)
  end

  it 'should contain events' do
    expect(@day.events).to be_a Array
    expect(@day.events.first).to eql @event
  end

  it 'should have a date with the same date as its events' do
    expect(@day.date).to eql @event.start_time.to_date
  end

  it 'should allow us to add more dates' do
    e = FactoryGirl.create(:event, title: 'A different event')
    @day.add_event(e)
    expect(@day.events).to include(e)
  end

  it 'should sort by date ascending' do
    e = FactoryGirl.create(:event_tomorrow)
    tomorrow = Day.new(e)
    expect([tomorrow, @day].sort.first).to eql @day
  end

end
