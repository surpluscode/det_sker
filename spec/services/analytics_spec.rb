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
    it 'should be ordered by count' do
      expect(subject.first.first).to eql 'calendar#index'
    end
  end
end
