class AnalyticsService
  def self.group_by(field)
    Ahoy::Event.group(field).order('count_id desc').count(:id)
  end
end