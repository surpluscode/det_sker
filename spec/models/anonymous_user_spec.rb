require 'spec_helper'

describe AnonymousUser do
  it 'should create an anonymous user when given a username' do
    anon = AnonymousUser.create_anonymous_user(username: 'secret_user')
    anon.should be_a User
    anon.is_anonymous?.should be_true
    anon.is_admin?.should be_false
  end

  it 'should return nil when not given a username' do
    anon = AnonymousUser.create_anonymous_user({})
    anon.should be_nil
  end

end
