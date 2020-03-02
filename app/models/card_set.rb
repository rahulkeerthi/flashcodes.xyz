class CardSet < ApplicationRecord
  belongs_to :language
  belongs_to :user_set
  has_many :flashcards
end
