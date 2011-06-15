require 'faker'

namespace :db do
  desc "fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name=>"brook" ,:email => "brook@ror.org",:password=>"brookbrook",:password_confirmation=>"brookbrook"  )
    99.times do |n|
      name = Faker::Name.name
      email = "brook-#{n+1}@ror.org"
      password="brookbrook"
      User.create!(:name=>name,:email=>email,:password=>password,:password_confirmation=>password)
    end
  end
end