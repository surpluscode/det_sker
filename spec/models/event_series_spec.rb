require 'spec_helper'

describe EventSeries do
  context 'on initialization' do
    let (:series_params) { {
        description: 'Sample description',
        start_time: DateTime.now,
        end_time: DateTime.now + 2.hours,
        title: 'Sample event series',
        location: Location.last
    }}
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

end
