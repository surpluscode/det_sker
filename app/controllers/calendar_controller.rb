class CalendarController < ApplicationController
  def index
    @calendar = Calendar.new(:coming)
    @posts = Post.where(featured: true)
  end

end