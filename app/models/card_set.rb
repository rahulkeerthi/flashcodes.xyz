class CardSet < ApplicationRecord
  belongs_to :language
  has_many :flashcards
end
