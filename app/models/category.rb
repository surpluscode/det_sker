class Category < ActiveRecord::Base
  has_many :events
  validates :danish, presence: true, uniqueness: { case_sensitive: false }
  validates :english, presence: true, uniqueness: { case_sensitive: false }

  def as_json(options = {})
    super(only: [:id, :key])
  end
end
