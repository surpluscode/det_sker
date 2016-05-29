require 'spec_helper'

describe AnalyticsService do
  describe 'group_by' do
    before do
      FactoryGirl.create(:ahoy_event_frontpage)
      FactoryGirl.create(:ahoy_event_frontpage)
      FactoryGirl.create(:ahoy_location_show)
    end
    subject { described_class.group_by(:name) }
    it { should be_a Hash }
    it 'should group by name' do
      expect(subject.values.size).to eql 2
    end
    it 'should be ordered by count' do
      expect(subject.first.first).to eql 'calendar#index'
    end
    it 'returns values as an array' do
      expect(subject.values.first).to be_an Array
    end
    it 'returns the absolute count as the first value' do
      expect(subject.values.first.first).to eql 2
    end
    it 'returns the percentage as the second value' do
      expect(subject.values.first.second.round(0)).to eql 67
    end
    it 'should render percentage values' do
      expect(subject.values.collect(&:last).inject(&:+)).to eql 100.0
    end
  end
end
