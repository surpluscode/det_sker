require 'spec_helper'

describe Event do
  it 'should create an event' do
    event = Event.new(title: 'Massive party', creator: 'FestAbe99', description: 'The Best Party Ever!')
    event.title.should match('Massive party')
  end
end
