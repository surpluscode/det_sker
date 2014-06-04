namespace :det_sker do
  desc 'remove all data from the db and reload fixtures'
  task reload: :environment  do
    ActiveRecord::Base.subclasses.each(&:delete_all)
    ENV['FIXTURES_PATH'] = 'spec/fixtures'
    Rake.application.invoke_task('db:fixtures:load')
  end
end