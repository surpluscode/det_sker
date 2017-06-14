require 'spec_helper'

describe ReminderService do
  before do
    @expiring_series = FactoryGirl.create(:expiring_series)
    @expired_series = FactoryGirl.create(:expired_series)
    @expired_series_already_warned = FactoryGirl.create(:expiring_series_expiring_warning_sent)
    @expired_series_already_warned = FactoryGirl.create(:expired_series_expired_warning_sent)
    ActionMailer::Base.deliveries.clear
  end
  describe 'send_expiring_reminders' do
    subject { ReminderService.send_expiring_reminders }
    it 'should send a mail to the relevant user and update the series' do
      expect { subject }.to change {
        ActionMailer::Base.deliveries.size
      }.from(0).to(1)
      @expiring_series.reload
      expect(@expiring_series.expiring_warning_sent).to eql true
    end
  end
  describe 'send expiry reminders' do
    subject { ReminderService.send_expiry_reminders }
    it 'should send a mail to the relevant user and update the series' do
      expect { subject }.to change {
        ActionMailer::Base.deliveries.size
      }.from(0).to(1)
      @expired_series.reload
      expect(@expired_series.expired_warning_sent).to eql true
    end
  end
end