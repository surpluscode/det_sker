require 'spec_helper'

describe Calendar do

  describe 'Calendar.new(:coming)' do
    before(:all) do
      l1 =  FactoryGirl.create(:location)
      l2 = FactoryGirl.create(:other_location)
      cat = FactoryGirl.create(:random_category)
      other_cat = FactoryGirl.create(:random_category)
      @event_now = FactoryGirl.create(:event, categories: [cat], location: l1)
      FactoryGirl.create(:event, start_time: DateTime.now + 1.hour,
                         categories: [cat], location: l1)
      @event_tomorrow = FactoryGirl.create(:event_tomorrow, categories: [other_cat],
                                           location: l2)
      @event_yesterday = FactoryGirl.create(:event_yesterday, location: l2)
      @cal = Calendar.new(:coming)
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
      @cal.events.should_not include(@event_yesterday)
    end

    it 'should include future events' do
      @cal.events.should include(@event_tomorrow)
    end

    it 'should return in progress events' do
      @cal.in_progress.first.should eql @event_now
    end


    it 'should return a hash of categories and their values' do
      @cal.filter_categories.should be_a Hash
      expect(@cal.filter_categories.length).to eq(2)
    end

    it 'should return a number of events for each category' do
      @cal.filter_categories.values.first.should be_a Fixnum
    end

    it 'should return a hash of locations and their values' do
      @cal.filter_locations.should be_a Hash
      expect(@cal.filter_locations.length).to eq(2)
    end

  end

end