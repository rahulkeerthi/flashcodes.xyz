#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'faker'
require 'open-uri'

puts "CLEANING DB"
User.destroy_all
Flashcard.destroy_all
CardSet.destroy_all
Language.destroy_all

puts "SEEDING USERS"

5.times do
  user = User.new(username: Faker::Internet.username, email: Faker::Internet.email, password: "123456", password_confirmation: "123456", bio: Faker::Hacker.say_something_smart)
  user.save
end

puts "SEEDING LANGUAGES"

f = File.open("db/sourcedata/proglangs.csv", "r")
f.each_line do |line|
  fields = line.split("|")
  lang = Language.new(name: fields[0].tr_s('"', '').strip, description: fields[1].tr_s('"', '').strip)
  file = URI.open(fields[2].tr_s('"', '').strip)
  # binding.pry
  lang.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  begin
    lang.save!
  rescue
    puts "Something wrong with #{fields[0].tr_s('"', '').strip}"
  end
end

puts "SEEDING FLASHCARDS AND CARD SETS"

10.times do
  card = Flashcard.new(question: Faker::Lorem.question(word_count: 6), correct_answer: "Correct", answer_1: "Wrong 1", answer_2: "Wrong 2", answer_3: "Wrong 3")
  set = CardSet.new(title: "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun}".capitalize, description: Faker::Hacker.say_something_smart, difficulty: ["Easy","Medium","Hard"].sample)
  offset = rand(Language.count)
  set.language = Language.offset(offset).first
  set.save
  10.times do
    card = Flashcard.new(question: Faker::Lorem.question(word_count: 6), correct_answer: "Correct", answer_1: "Wrong 1", answer_2: "Wrong 2", answer_3: "Wrong 3")
    card.card_set = set
    card.save
  end
end
