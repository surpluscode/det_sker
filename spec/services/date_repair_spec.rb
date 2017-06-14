require 'spec_helper'
describe DateRepair do
  let(:start_time) { Time.zone.now - 1.hour }
  let(:end_time) { Time.zone.now + 1.hour }
  let(:event) {
    Event.new(title: "HVAD FEJLER KLIMABEVIDSTHEDEN?", short_description: "Det alternative topmøde 'System Change, not climat...", start_time: start_time, end_time: end_time, created_at: "2017-03-24 11:48:56", updated_at: "2017-03-24 11:48:56", price: "12kr", cancelled: nil, long_description: nil, user_id: 962538434, location_id: 5, comments_enabled: true, link: nil, picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, event_series_id: nil, featured: false, published: true)
  }
  describe 'repair' do
    it 'should return a version of the event with the dates in utc' do
      expect(DateRepair.repair(event)).to be_an Event
      expect(DateRepair.repair(event)).to eql event
    end
  end
end
