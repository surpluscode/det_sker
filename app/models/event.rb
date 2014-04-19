class Event < ActiveRecord::Base
  attr_accessor :title, :description, :location, :start_time, :end_time, :category, :creator
  validates :title, :description, :location, :start_time, :end_time, :category, :creator, presence: true
end
