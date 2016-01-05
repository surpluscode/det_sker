class Category < ActiveRecord::Base
  validates :danish, presence: true, uniqueness: { case_sensitive: false }
  validates :english, presence: true, uniqueness: { case_sensitive: false }
  has_and_belongs_to_many :events

  # Return a grouped set of categories containing current events
  # we need to use raw SQL here because we don't have a CategoriesEvents model
  # we can refer to. It could also be possible to iterate through all events to
  # load their associated categories, but this is presumed to be faster
  # (ruby iteration on in-mem object plus one query rather than n queries where n is num events)
  def self.categories_for(events)
    ids = events.collect(&:id)
    return [] if ids.empty?
    ActiveRecord::Base.connection.execute(
        "SELECT category_id AS id, COUNT(event_id) AS num from categories_events
        WHERE event_id IN (#{ids.join(', ')}) GROUP BY category_id;"
     )
  end

  def as_json(options = {})
    super(only: [:id, :english, :danish])
  end
end
