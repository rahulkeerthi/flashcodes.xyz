class UserAnswer < ApplicationRecord
  belongs_to :user_set
  belongs_to :flashcard

  validates :correct, inclusion: {in: [true, false]}
end
