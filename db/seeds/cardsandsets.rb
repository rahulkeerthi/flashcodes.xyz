#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "SEEDING FLASHCARDS AND CARD SETS"

Language.all.each do |lang|
  10.times do
    set = CardSet.new(title: "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun}".capitalize, description: Faker::Hacker.say_something_smart, difficulty: ["Easy","Medium","Hard"].sample)
    set.language = lang
    set.save
    10.times do
      card = Flashcard.new(question: Faker::Lorem.question(word_count: 6), correct_answer: "Correct", answer_1: "Wrong 1", answer_2: "Wrong 2", answer_3: "Wrong 3")
      card.card_set = set
      card.save
    end
  end
end
