require 'spec_helper'

describe Calendar do

  describe 'Calendar.new(:coming)' do
    before(:all) do
      l1 =  FactoryGirl.create(:location)
      l2 = FactoryGirl.create(:other_location, name: nil, street_address: 'Strandvejen 49')
      @cat = FactoryGirl.create(:random_category)
      other_cat = FactoryGirl.create(:random_category)
      @event_now = FactoryGirl.create(:event, category: @cat, location: l1)
      FactoryGirl.create(:event, start_time: DateTime.now + 1.hour,
                         category: @cat, location: l1)
      @event_tomorrow = FactoryGirl.create(:event_tomorrow, category: other_cat,
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

    it 'should not crash if an event does not have a location' do
      Event.new(start_time: DateTime.now + 1.hour, end_time: DateTime.now + 2.hour).save(validate: false)
      expect { Calendar.new(:coming) }.not_to raise_exception
    end

    describe 'filter_categories' do
      it 'should return an array of arrays' do
        expect(@cal.filter_categories).to be_an Array
        expect(@cal.filter_categories.first).to be_an Array
      end

      it 'should return a number of events for each category' do
        expect(@cal.filter_categories.first.last).to be_a Fixnum
      end

      it 'should order the categories by the number of events descending' do
        first = @cal.filter_categories.first
        last = @cal.filter_categories.last
        expect(first.last).to be > last.last
      end
    end

    describe 'filter_locations' do
      it 'should return an array of arrays' do
        expect(@cal.filter_locations).to be_an Array
        expect(@cal.filter_locations.first).to be_an Array
      end

      it 'uses the street address when no name is present' do
        expect(@cal.filter_locations.flatten).to include 'Strandvejen 49'
      end
    end
  end
end