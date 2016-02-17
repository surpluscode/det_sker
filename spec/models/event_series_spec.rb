require 'spec_helper'

describe EventSeries do
  let (:series_params) { {
      description: 'Sample description',
      start_time: DateTime.now,
      end_time: DateTime.now + 2.hours,
      title: 'Sample event series',
      location: Location.last
  }}
  context 'on initialization' do
    let (:series) { EventSeries.new }
    it 'should be possible to set a description' do
      series.description = 'Sample description'
      expect(series.description).to eql 'Sample description'
    end
    it 'should be possible to set a starttime'
    it 'should be possible to set a endtime'
    it 'should be possible to set multiple categories'
    it 'should be possible to set a location'
  end

  context 'creating' do
    subject { FactoryGirl.create(:event_series) }
    it { should be_valid }
    it 'should have child events' do
      expect(subject.events.size).to be > 0
    end
    it 'should have child events with the same details' do
      expect(subject.events.first.short_description).to eql subject.description
    end
  end

  context 'updating' do
    subject { FactoryGirl.create(:event_series) }
    before do

    end

    it 'should update the child events' do
      #expect(subject.events.first.short_description).to eql 'A new description'
    end

    it 'does not create new events' do
      expect{
        subject.update(description: 'A new description')
      }.not_to change{subject.events.count}
    end

  end

end