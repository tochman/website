# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

#User.create({:email => 'user1@example.com',
#              :password => 'user1234',
#              :password_confirmation => 'user1234',
#              :first_name => 'Anders',
#              :last_name => 'Andersson',
#              :avatar => open('app/assets/images/anonymous_avatar.gif'),
#              :created_at => Date.today })
#User.create({:email => 'user2@example.com',
#             :password => 'user4321',
#             :password_confirmation => 'user4321',
#             :first_name => 'Kalle',
#             :last_name => 'Karlsson',
#             :avatar => File.open('app/assets/images/anonymous_avatar.gif'),
#             :created_at => Date.today })


Subject.create!({:name => 'Learning Rails',
                 :description => 'We are learning RoR together by remote pair programming and having fun.',
                 :group_url => 'https://plus.google.com/u/0/communities/100279740984094902927?cfem=1' })
Subject.create!({:name => 'Front end',
                 :description => 'We are designing front end UI with css3, HTML5 and jQuery.',
                 :group_url => 'http://plus.google.com/frontend' })
Subject.create!({:name => 'Testing',
                 :description => 'We are focusing on test with rspec and cucumber.',
                 :group_url => 'https://plus.google.com/u/0/communities/100279740984094902927?cfem=1' })

