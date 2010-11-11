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
                       :city => "Berlin",
                       :password => "Very_Geheim",
                       :password_confirmation => "Very_Geheim")
#  admin.toggle!(:admin)
  10.times do
    name = Faker::Name.name
    email = Faker::Internet.email
    city = Faker::Address.city
    password = "Very_Geheim"
    User.create!(:name => name,
                 :email => email,
                 :city => city,
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

