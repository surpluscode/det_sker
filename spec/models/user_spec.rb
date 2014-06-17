require 'spec_helper'

describe User do

  describe 'can_edit' do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it 'should allow a user to edit themselves' do
      expect(@user.can_edit? @user).to be_true
    end

    it 'should not allow a normal user to edit another user' do
      u = FactoryGirl.create(:user, email: 'something@user.com', username: 'another_user')
      expect(u.can_edit? @user).to be_false
    end

    it 'should allow an admin user to edit another user' do
      admin = FactoryGirl.create(:admin_user)
      expect(admin.can_edit? @user).to be_true
    end
  end

  describe 'coming events' do
    it 'shows the users coming events only' do
      u = FactoryGirl.create(:user)
      u.events << FactoryGirl.create(:event_yesterday)
      u.events << FactoryGirl.create(:event_tomorrow)
      u.events.length.should be_eql 2
      u.coming_events.length.should be_eql 1
    end
  end
end