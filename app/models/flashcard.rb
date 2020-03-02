class Flashcard < ApplicationRecord
  belongs_to :set
  has_many :user_answers
end
