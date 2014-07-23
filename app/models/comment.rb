class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates_associated :user, :event
  validates :user, :event, presence: true
end