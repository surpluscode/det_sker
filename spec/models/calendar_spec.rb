require 'spec_helper'

describe Calendar do

  describe 'Calendar.new(:coming)' do
    before(:each) do
      FactoryGirl.create(:event, categories: [FactoryGirl.create(:category)])
      @event_tomorrow = FactoryGirl.create(:event_tomorrow, categories: [FactoryGirl.create(:category, key: :demo)])
      FactoryGirl.create(:event_yesterday)
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
      @cal.days.should_not include(@event_tomorrow)
    end

    it 'should return a hash of categories and their values' do
      @cal.categories.should be_a Hash
      expect(@cal.categories.length).to eq(2)
    end

    it 'should return the category contained in the Event object' do
      @cal.categories.keys.should include(:party)
    end

    it 'should return a number of events for each category' do
      @cal.categories.values.first.should be_a Fixnum
    end

  end

end