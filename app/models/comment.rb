class ValidUser < ActiveModel::Validator
  def validate(comment)
    if comment.user && comment.user.is_anonymous?
      comment.errors[:base] << 'Anonymous users cannot leave comments'
    end
  end
end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates_associated :user, :event
  validates :event, :user, presence: true
  validates_with ValidUser

end