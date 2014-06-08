namespace :det_sker do
  desc 'remove all data from the db and reload fixtures'
  task reload: :environment  do
    truncate_all_tables
    Rake.application.invoke_task('db:seed')
    ENV['FIXTURES_PATH'] = 'spec/fixtures'
    Rake.application.invoke_task('db:fixtures:load')
  end

  def truncate_all_tables
    (ActiveRecord::Base.connection.tables - ['schema_migrations', 'categories_events']).each do |table|
      table.classify.constantize.destroy_all
    end
  end

end