class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events
  validates :username, presence: true

  # ensure user is permitted to edit event
  def can_edit?(event)
    id == event.user_id
  end
end
