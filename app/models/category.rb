class Category < ActiveRecord::Base
  validates :key, presence: true
  has_and_belongs_to_many :events

  # Return a grouped set of categories containing current events
  # we need to use raw SQL here because we don't have a CategoriesEvents model
  # we can refer to.
  # This is dangerous because the SQL might not be compatible across dbs
  def self.current_categories
     ActiveRecord::Base.connection.execute(
         "SELECT c.key, COUNT(*) AS num from categories_events AS ce, events AS e, categories AS c
          WHERE ce.event_id = e.id AND ce.category_id = c.id
          AND e.end_time > DATETIME('now')
          GROUP BY c.key"
     )
  end
end