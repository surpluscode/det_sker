class User < ActiveRecord::Base
  include HasEvents

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  alias_method :user_id, :id

  validates :username, presence: true, uniqueness: true

  # ensure user is permitted to edit object
  # either if the user is an admin or if
  # the user has created the object
  def can_edit?(object)
    self.is_admin? || id == object.user_id
  end

  def make_admin
    self.is_admin = true
    self.save
  end

  # the name method is an alias used
  # by the page title helper
  def name
    username
  end

end
