class Event < ActiveRecord::Base
  validates :title, :short_description, :start_time, :end_time, :location_id, :user_id, presence: true

  belongs_to :user
  belongs_to :location
  has_and_belongs_to_many :categories
  has_many :comments

  def in_progress?
    start_time < DateTime.now && end_time > DateTime.now
  end

  def self.current_events
    self.includes(:user, :location, :comments).order(:start_time).where('end_time > ?', DateTime.now)
  end

end
