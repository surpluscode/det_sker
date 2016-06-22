require 'spec_helper'

describe Calendar do

  describe 'Calendar.new(:coming)' do
    before(:all) do
      l1 =  FactoryGirl.create(:location)
      l2 = FactoryGirl.create(:other_location, street_address: 'Strandvejen 49')
      @cat = FactoryGirl.create(:random_category)
      other_cat = FactoryGirl.create(:random_category)
      @event_now = FactoryGirl.create(:event, categories: [@cat], location: l1)
      FactoryGirl.create(:event, start_time: DateTime.now + 1.hour,
                         categories: [@cat], location: l1)
      @event_tomorrow = FactoryGirl.create(:event_tomorrow, categories: [other_cat],
                                           location: l2)
      @event_yesterday = FactoryGirl.create(:event_yesterday, location: l2)
      @unpublished_event = FactoryGirl.create(:unpublished_event)
      @cal = Calendar.new
    end

    it 'should return an array of days' do
      expect(@cal.days).to be_an Array
      expect(@cal.days.first).to be_a Day
    end

    it 'should order its days by date ascending' do
      expect(@cal.days.length).to eq(2)
      expect(@cal.days.first.date).to be < @cal.days.last.date
    end

    it 'should not return past events' do
      expect(@cal.events).not_to include(@event_yesterday)
    end

    it 'should include future events' do
      expect(@cal.events).to include(@event_tomorrow)
    end

    it 'should return in progress events' do
      expect(@cal.in_progress.first).to eql @event_now
    end

    it 'should not return unpublished events' do
      expect(@cal.in_progress).not_to include @unpublished_event
    end

    it 'should not crash if an event does not have a location' do
      Event.new(start_time: DateTime.now + 1.hour, end_time: DateTime.now + 2.hour).save(validate: false)
      expect { Calendar.new }.not_to raise_exception
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
    end
  end
  describe 'Calendar.for_user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:published) { FactoryGirl.create(:event, user: user) }
    let(:unpublished) { FactoryGirl.create(:unpublished_event, user: user) }
    subject { Calendar.for_user(user) }
    # make sure everything is initialized
    before { published && unpublished }

    it 'should include unpublished events' do
      expect(subject.events).to include unpublished
    end
    it 'should include published events' do
      expect(subject.events).to include published
    end
  end
end