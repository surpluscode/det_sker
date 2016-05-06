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

  describe 'events' do
    let(:user) { FactoryGirl.create(:user) }
    let(:future_event) { FactoryGirl.create(:event_tomorrow) }
    let(:past_event) { FactoryGirl.create(:event_yesterday) }
    let(:unpublished_event) { FactoryGirl.create(:unpublished_event) }
    before do
      user.events.clear
      user.events << future_event << past_event << unpublished_event
    end
    describe 'coming events' do
      subject { user.coming_events }
      it { should include future_event }
      it { should_not include past_event }
      it { should_not include unpublished_event }
    end

    describe 'unpublished events' do
      subject { user.unpublished_events }
      it { should =~ [unpublished_event] }
    end
  end
  # describe 'expiring event queries' do
  #   let(:user) { FactoryGirl.create(:user) }
  #   let(:expiring_series) { FactoryGirl.create(:expiring_series, user: user) }
  #   let(:expired_series) { FactoryGirl.create(:expired_series, user: user) }
  #   let(:active_series) { FactoryGirl.create(:weekly_series, user: user) }
  #   describe 'expiring series' do
  #     subject { User.expiring_series }
  #     it { should include expiring_series }
  #     it { should_not include expired_series }
  #     it { should_not include active_series }
  #   end
  #   describe 'expired series' do
  #     subject { User.expired_series }
  #     it { should include expired_series }
  #     it { should_not include expiring_series }
  #     it { should_not include active_series }
  #   end
  # end
end