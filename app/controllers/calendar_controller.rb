class CalendarController < ApplicationController
  def index
    @calendar = Calendar.new(:coming)
  end

end