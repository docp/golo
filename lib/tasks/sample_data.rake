require 'faker' # faker gem

namespace :db do
  desc "Fill database with users and relationships"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_relationships
  end
end

def make_users
  admin = User.create!(:name => "First User",
                            :email => "first@user.com",
                            :password => "Very_Geheim",
                            :password_confirmation => "Very_Geheim")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name,
    email = "example-#{n+1}@user.com",
    password = "password",
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

