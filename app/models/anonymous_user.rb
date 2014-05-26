class AnonymousUser < User
  # Given a hash with a username
  # create an anonymous user with
  # default values
  def self.create_anonymous_user(attrs)
    random_str = Time.now.to_i + rand(99)
    attrs.merge!(email: "#{random_str}@anon.com", confirmed_at: DateTime.now,
      encrypted_password: "#{random_str}", is_admin: false, is_anonymous: true )
    User.create(attrs) unless attrs[:username].nil?
  end
end
