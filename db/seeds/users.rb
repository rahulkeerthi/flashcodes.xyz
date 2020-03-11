#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "CLEANING DB"
User.destroy_all

puts "SEEDING USERS"

5.times do
  puts "Creating user"
  user = User.new(username: Faker::Internet.username, email: Faker::Internet.email, password: "123456", password_confirmation: "123456", bio: Faker::Hacker.say_something_smart)
  puts "Opening file"
  file = URI.open("https://loremflickr.com/320/240")
  puts "Attaching image to the user"
  user.photo.attach(io: file, filename: 'nes.png')
  puts "Save the user to the DB"
  user.save!
end
