class Event < ActiveRecord::Base
  validates :title, :description, :location, :start_time, :end_time, :category, :creator, presence: true
end
