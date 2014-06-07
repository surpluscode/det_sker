require 'spec_helper'

describe Location do

  before(:each) do
    @location = {name: 'Folkets Hus', street_address: 'Stengade 50',
                 postcode: '2200',  town: 'Nørrebro',
                 description: 'Folkets Hus er et lokalt, social og politisk brugerstyret hus i hjertet af Nørrebro.',
                 latitude: 12.554228, longitude: 55.687301}
  end

  it 'should save a valid location' do
    l = Location.new(@location)
    l.valid?.should be_true
  end

  it 'should refuse to save without street address' do
    @location.delete(:street_address)
    l = Location.new(@location)
    l.valid?.should be_false
  end

  it 'should refuse to save without town' do
    @location.delete(:town)
    l = Location.new(@location)
    l.valid?.should be_false
  end
end