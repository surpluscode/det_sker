namespace :det_sker do
  desc 'remove all data from the db and reload fixtures'
  task reload: :environment  do
    truncate_all_tables
    Rake.application.invoke_task('db:seed')
    ENV['FIXTURES_PATH'] = 'spec/fixtures'
    Rake.application.invoke_task('db:fixtures:load')
  end

  def truncate_all_tables
    (ActiveRecord::Base.connection.truncate_all_tables - ['schema_migrations', 'categories_events', 'event_series_categories']).each do |table|
      table.classify.constantize.destroy_all
    end
  end

  desc 'create an admin user given an email, username and password'
  task :create_admin, [:email, :username, :password] => :environment do |t, args|
    u = User.new(
        is_admin: true, email: args[:email], username: args[:username],
        password: args[:password], password_confirmation: args[:password],
    )
    u.skip_confirmation!
    raise "User could not be saved! #{u.errors.messages}" unless u.save
    puts "Admin user #{args[:username]} created with email #{args[:email]} and password #{args[:password]}"
  end
end