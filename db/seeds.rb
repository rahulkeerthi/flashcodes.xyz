#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'faker'

puts "SEEDING USERS"

20.times do
  user = User.new(username: Faker::Internet.username, email: Faker::Internet.email, password: "123456", password_confirmation: "123456", bio: Faker::Hacker.say_something_smart)
  user.save
end

puts "SEEDING LANGUAGES"

f = File.open("db/sourcedata/proglangs.csv", "r")
f.each_line do |line|
  fields = line.split("|")
  lang = Language.new(name: fields[0].tr_s('"', '').strip, description: fields[1].tr_s('"', '').strip)
  lang.save
end

puts "SEEDING FLASHCARDS AND CARD SETS"

200.times do
  card = Flashcard.new(question: Faker::Lorem.question(word_count: 6), correct_answer: "Correct", answer_1: "Wrong 1", answer_2: "Wrong 2", answer_3: "Wrong 3")
  set = CardSet.new(title: "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun}", description: Faker::Hacker.say_something_smart, difficulty: ["Easy","Medium","Hard"].sample, language_id: (1..24).to_a.sample)
  # card.save
  offset = rand(Language.count)
  # set.save
  set.language = Language.offset(offset).first
  card.card_set_id = set
  set.save
  card.save
end
