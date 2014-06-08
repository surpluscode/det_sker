require 'spec_helper'

describe Location do

  before(:each) do
    @location = FactoryGirl.attributes_for(:location)
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