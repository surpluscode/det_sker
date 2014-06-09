require 'spec_helper'

describe Calendar do

  it 'should contain an array of Days' do
    calendar = Calendar.new
    calendar.days.should be_an Array
  end

  describe "Calendar.new('coming')" do
    before(:each) do
      FactoryGirl.create(:event)
      @event_tomorrow = FactoryGirl.create(:event_tomorrow)
      FactoryGirl.create(:event_yesterday)
      @cal = Calendar.new('coming')
    end

    it 'should return an array of days' do
      @cal.days.should be_an Array
      @cal.days.first.should be_a Day
    end

    it 'should order its days by date ascending' do
      expect(@cal.days.length).to eq(2)
      expect(@cal.days.first.date).to be < @cal.days.last.date
    end

    it 'should not return past events' do
      @cal.days.should_not include(@event_tomorrow)
    end

  end

end