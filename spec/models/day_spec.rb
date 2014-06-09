require 'spec_helper'

describe Day do
  before :each do
    @event = FactoryGirl.create(:event)
    @day = Day.new(@event)
  end

  it 'should contain events' do
    @day.events.should be_a Array
    @day.events.first.should eql @event
  end

  it 'should have a date with the same date as its events' do
    @day.date.should eql @event.start_time.to_date
  end

  it 'should allow us to add more dates' do
    e = FactoryGirl.create(:event, title: 'A different event')
    @day.add_event(e)
    @day.events.should include(e)
  end

  it 'should throw an exception given a day with a different date' do
    e = FactoryGirl.create(:event, start_time: DateTime.now - 5.days)
    expect { @day.add_event(e) }.to raise_error
  end

end