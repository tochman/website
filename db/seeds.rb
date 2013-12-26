# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

User.create!({:email => 'user1@example.com',
              :password => 'user1234',
              :password_confirmation => 'user1234',
              :first_name => 'Anders',
              :last_name => 'Andersson',
              :created_at => Date.today })
User.create!({:email => 'user2@example.com',
             :password => 'user4321',
             :password_confirmation => 'user4321',
             :first_name => 'Kalle',
             :last_name => 'Karlsson',
             :created_at => Date.today })

