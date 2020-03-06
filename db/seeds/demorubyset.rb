require 'faker'


puts "SEEDING DEMO FLASHCARDS AND CARD SETS"


# 15.times do
#   set = CardSet.new(title: "#{Faker::Hacker.ingverb.capitalize} #{Faker::Hacker.noun.capitalize}", description: "#{Faker::Hacker.say_something_smart.capitalize}. #{Faker::Hacker.say_something_smart.capitalize}.}", difficulty: ["Easy","Medium","Hard"].sample)
#   set.language = Language.where(name: "Ruby")
#   set.save
#   10.times do
#     card = Flashcard.new(question: Faker::Lorem.question(word_count: 6), correct_answer: "Correct", answer_1: "Wrong 1", answer_2: "Wrong 2", answer_3: "Wrong 3")
#     card.card_set = set
#     card.save
#   end
# end

set = CardSet.new(title: "Iterators and Blocks", description: "Explore ruby iterators and learn to yield to yield when calling a block with a method.", difficulty: "Impossible", language: Language.find(9))
set.save


card = Flashcard.new(
  question: "How do you clean an Array from items matching a condition?",
  correct_answer: "You can call #reject iterator on it, passing it the condition in a block",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

card = Flashcard.new(
  question: "Is there a way to have the index and the element when you iterate through an Array?",
  correct_answer: "You can use #each_with_index",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

card = Flashcard.new(
  question: "How do you quickly build an Array of integer from 5 to 25?",
  correct_answer: "You can build a Range instance on which you call #to_a",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

card = Flashcard.new(
  question: "How do you define a method that can accept a block as an argument?",
  correct_answer: "You need to use the yield keyword in your method’s definition. When the method is called with a block, the block will be called when yield occurs.",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

card = Flashcard.new(
  question: "How can you compute the sum of integers stored in an Array?",
  correct_answer: "You can call #sum iterator on it.",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

card = Flashcard.new(
  question: "Is there a way to have the index and the element when you iterate through an Array?",
  correct_answer: "You can use #each_with_index",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

card = Flashcard.new(
  question: "How would you sort an Array with a given sorting criteria?",
  correct_answer: "You can call #sort_by on it, passing it the sorting criteria in a block.",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

card = Flashcard.new(
  question: "How much yield can a yield block proc if a yield block will proc yield?",
  correct_answer: "Submit a ticket.",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

card = Flashcard.new(
  question: "How would you define a method accepting a block with dynamic parameters?",
  correct_answer: "You need to use yield(parameters).",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

card = Flashcard.new(
  question: "Which iterator should you call on an Array to get another Array where all the elements were subject to the same treatment?",
  correct_answer: "You should use #map.",
  answer_1: "#{Faker::Hacker.say_something_smart}.",
  answer_2: "#{Faker::Hacker.say_something_smart}.",
  answer_3: "#{Faker::Hacker.say_something_smart}.",
  card_set: set
  )
card.save

