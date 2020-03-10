class UserSet < ApplicationRecord
  belongs_to :user
  belongs_to :card_set
  has_many :user_answers, dependent: :destroy
  has_many :flashcards, through: :user_answers
  has_many :group_memberships
  validates :completed, inclusion: {in: [true, false]}
end
