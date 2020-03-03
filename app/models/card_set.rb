class CardSet < ApplicationRecord
  belongs_to :language
  has_many :user_sets
  has_many :flashcards

  validates :title, :description, :difficulty, presence: true
  validates :difficulty, inclusion: { in: ["Easy", "Medium", "Hard"] }
end
