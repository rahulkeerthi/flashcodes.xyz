class CardSet < ApplicationRecord
  belongs_to :language
  has_many :user_sets
  has_many :flashcards
end
