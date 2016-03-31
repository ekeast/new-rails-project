# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
5.times do
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Internet.password(8, 15)
  )
end

users = User.all

10.times do
  Registration.create!(
    user: users.sample,
    name: Faker::App.name,
    url: Faker::Internet.url
  )
end

registrations = Registration.all

20.times do
  Event.create!(
  registration: registrations.sample,
  name: Faker::Hacker.verb
  )
end

puts "Seeds finished!"
puts "#{User.count} users created"
puts "#{Registration.count} registrations created"
puts "#{Event.count} events created"
