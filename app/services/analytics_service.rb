class AnalyticsService
  include ActiveRecord::Sanitization
  VALID_INTERVALS = %w(hour day week month quarter year)

  # Return a sorted Hash of fields grouped by field
  # with counts represented as both absolute and as percentage
  # e.g. { 'calendar#index' => [3, 100.0] }
  def self.group_by(field)
    grouped = Ahoy::Event.group(field).order('count_id desc').count(:id)
    total_count = grouped.values.inject(&:+)
    factor = 100.0 / total_count.to_f
    grouped.transform_values {|val| [val, (val.to_f) * factor] }
  end

  def self.time_series(field, interval)
    return {} unless interval.in? VALID_INTERVALS
    # if we're looking for all values, field will be empty
    where_clause = field.present? ? "WHERE name LIKE '#{sanitize_sql_like(field)}'" : ''
    sql = "SELECT date_trunc('#{interval}', time) AS \"#{interval}\", COUNT(id) FROM ahoy_events %{where}
        GROUP BY #{interval}" % { where:  where_clause }
    begin
      result = ActiveRecord::Base.connection.execute(sql)
      series = {}
      result.collect do |h|
        series.store(h[interval], h['count'])
      end
      series
    rescue ActiveRecord::StatementInvalid => e
      Rails.logger.error "Error generating time series #{e.message}"
      {}
    end
  end
end