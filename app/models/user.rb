class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events
  alias_method :user_id, :id

  validates :username, presence: true, uniqueness: true

  # ensure user is permitted to edit object
  def can_edit?(object)
    self.is_admin? || id == object.user_id
  end

  def make_admin
    self.is_admin = true
    self.save
  end

  def coming_events
    events.where('end_time > ?', DateTime.now)
  end

end
