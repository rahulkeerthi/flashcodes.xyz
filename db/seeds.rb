#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'faker'
require 'open-uri'

puts "CLEANING DB"
Group.destroy_all
GroupMembership.destroy_all
UserSet.destroy_all
UserAnswer.destroy_all
User.destroy_all
CardSet.destroy_all
Flashcard.destroy_all
Language.destroy_all

puts "SEEDING USERS"

5.times do
  user = User.new(username: Faker::Internet.username, email: Faker::Internet.email, password: "123456", password_confirmation: "123456", bio: Faker::Hacker.say_something_smart)
  file = URI.open("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg")
  user.photo.attach(io: file, filename: 'nes.png')
  user.save!
end

puts "Adding ADMIN!"

user = User.new(username: "admin", email: "admin@admin.com", password: "123456", password_confirmation: "123456", bio: Faker::Hacker.say_something_smart, admin: true)
  file = URI.open("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg")
  user.photo.attach(io: file, filename: 'nes.png')
  user.save!

puts "DONE! SEEDING LANGUAGES"

f = File.open("db/sourcedata/proglangs.csv", "r")
f.each_line do |line|
  fields = line.split("|")
  lang = Language.new(name: fields[0].tr_s('"', '').strip, description: fields[1].tr_s('"', '').strip)
  file = URI.open(fields[2])
  puts "attaching image"
  lang.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  begin
    lang.save!
    puts "language saved"
  rescue
    puts "Something wrong with #{fields[0].tr_s('"', '').strip}"
  end
end

puts "DONE! SEEDING FLASHCARDS AND CARD SETS"

Language.all.each do |lang|
  10.times do
    set = CardSet.new(title: "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun}".capitalize, description: Faker::Hacker.say_something_smart, difficulty: ["Easy","Medium","Hard"].sample)
    set.language = lang
    set.save
    10.times do
      card = Flashcard.new(question: Faker::Lorem.question(word_count: 6), correct_answer: "Correct- #{Faker::Hacker.say_something_smart} #{Faker::Hacker.say_something_smart}", answer_1: "Wrong 1 - #{Faker::Hacker.say_something_smart} #{Faker::Hacker.say_something_smart}", answer_2: "Wrong 2 - #{Faker::Hacker.say_something_smart} #{Faker::Hacker.say_something_smart}", answer_3: "Wrong 3 - #{Faker::Hacker.say_something_smart} #{Faker::Hacker.say_something_smart}")
      card.card_set = set
      card.save
    end
  end
end

puts "DONE! Seeding Groups and Memberships"
puts "CREATING GROUPS"

Language.all.each do |lang|
  group = Group.new(name: "#{Faker::Coffee.blend_name} #{Faker::Creature::Animal.name.capitalize}s", full: false, language:lang)
  group.save
end

puts "GROUPS DONE - CREATING MEMBERSHIPS"

User.all.each do |user|
  Group.all.sample(10).each do |group|
    random_points = (rand(1..10) * 10)
    GroupMembership.create(user: user, group: group, points: random_points)
    puts "membership done!"
  end
  random_points = (rand(1..10) * 10)
  user.points = random_points
  user.save
  puts "user done!"
end

puts "ALL DONE! :)"
