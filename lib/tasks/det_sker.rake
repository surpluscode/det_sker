namespace :det_sker do
  desc 'remove all data from the db and reload fixtures'
  task reload: :environment  do
    Rake.application.invoke_task('db:seed')
    ENV['FIXTURES_PATH'] = 'spec/fixtures'
    Rake.application.invoke_task('db:fixtures:load')
  end
  
  desc 'create an admin user given an email, username and password'
  task :create_admin, [:email, :username, :password] => :environment do |t, args|
    create_user(args[:email], args[:username], args[:password], true)
    puts "Admin user #{args[:username]} created with email #{args[:email]} and password #{args[:password]}"
  end

  desc 'create a standard user given an email, username and password'
  task :create_user, [:email, :username, :password] => :environment do |t, args|
    create_user(args[:email], args[:username], args[:password])
    puts "User #{args[:username]} created with email #{args[:email]} and password #{args[:password]}"
  end

  def create_user(email, username, password, admin = false)
    u = User.new(
      is_admin: admin, email: email, email_confirmation: email,
      username: username, password: password, password_confirmation: password,
    )  
    u.skip_confirmation!    
    raise "User could not be saved! #{u.errors.messages}" unless u.save
  end

  desc 'email all users with series expiring within the week'
  task :send_expiring_reminders => :environment do
    ReminderService.send_expiring_reminders
  end

  desc 'email all users with expired series'
  task :send_expiry_reminders => :environment do
    ReminderService.send_expiry_reminders
  end
end