class Category < ActiveRecord::Base
  validates :key, presence: true
  has_and_belongs_to_many :events

  # Return a grouped set of categories containing current events
  def self.current_categories
     self.select('count(*) as num').includes(:events)
     .where('events.end_time > ?', DateTime.now).references(:events).group(:key)
  end
end
