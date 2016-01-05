class CalendarController < ApplicationController
  def index
    @calendar = Calendar.new
    @posts = Post.where(featured: true)
  end

end