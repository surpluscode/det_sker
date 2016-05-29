class AnalyticsService
  # Return a sorted Hash of fields grouped by field
  # with counts represented as both absolute and as percentage
  # e.g. { 'calendar#index' => [3, 100.0] }
  def self.group_by(field)
    grouped = Ahoy::Event.group(field).order('count_id desc').count(:id)
    total_count = grouped.values.inject(&:+)
    factor = 100.0 / total_count.to_f
    grouped.transform_values {|val| [val, (val.to_f) * factor] }
  end
end