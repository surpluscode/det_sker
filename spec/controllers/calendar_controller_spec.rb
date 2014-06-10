require 'spec_helper'

describe CalendarController do
  describe 'GET#index' do
    before(:each) do
      Calendar.new(:coming)
    end

    it 'should return a calendar object' do
      get :index
      assigns(:calendar).should be_a Calendar
    end

  end
end