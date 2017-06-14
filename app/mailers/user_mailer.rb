class UserMailer < ActionMailer::Base
  default from: 'reminders@dukop.dk'

  def expiring_warning_email(series)
    warning_email(series,  "Din serie skal snart fornyes / Your event series needs to be renewed")
  end

  def expired_warning_email(series)
    warning_email(series, "Din serie er nu udløbet / Your series has now expired")
  end

  def warning_email(series, title)
    @user = series.user
    @series = series
    if @user.is_anonymous?
      logger.error "Cannot send reminder mail to anonymous user for series #{series.id}"
      return
    end
    @url = edit_event_series_url(@series)
    email_with_name = "#{@user.username} <#{@user.email}>"
    mail(to: email_with_name, subject: title)
  end
end