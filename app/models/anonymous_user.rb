class AnonymousUser
  # Create attributes for anonymous user
  def self.attributes(attrs)
    random_str = Time.now.to_i.to_s + (0...16).map { (65 + rand(26)).chr }.join
    attrs.merge(email: "#{random_str}@anon.com", confirmed_at: DateTime.now,
                 password: random_str, is_admin: false, is_anonymous: true,
                 username: "anon_#{random_str}" )
  end
end
