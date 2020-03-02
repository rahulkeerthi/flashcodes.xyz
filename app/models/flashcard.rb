class Flashcard < ApplicationRecord
  belongs_to :card_set
  has_many :user_answers

  validates :question, :correct_answer, :answer_1, :answer_2, :answer_3, presence: true
end
