class CalendarController < ApplicationController

  def index
    @calendar = Calendar.new(:coming)
    respond_to do |format|
      format.html
      format.json
    end
  end

end