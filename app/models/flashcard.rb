class Flashcard < ApplicationRecord
  belongs_to :card_set
  has_many :user_answers
end
