class ReminderService
  def self.send_expiring_reminders
    EventSeries.expiring.expiring_warning_not_sent.each do |series|
      UserMailer.expiring_warning_email(series).deliver_now
      series.update(expiring_warning_sent: true)
    end
    true
  end

  def self.send_expiry_reminders
    EventSeries.expired.expired_warning_not_sent.each do |series|
      UserMailer.expired_warning_email(series).deliver_now
      series.update(expired_warning_sent: true)
    end
  end
end