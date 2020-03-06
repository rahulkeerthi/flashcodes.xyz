class CardSet < ApplicationRecord
  belongs_to :language
  has_many :user_sets
  has_many :flashcards

  validates :title, :description, :difficulty, presence: true
  validates :difficulty, inclusion: { in: ["Easy", "Medium", "Hard", "Impossible"] }

  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
    against: [ :title, :description ],
    using: {
      tsearch: { prefix: true }
    }
end
