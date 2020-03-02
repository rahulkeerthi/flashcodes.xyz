class UserAnswer < ApplicationRecord
  belongs_to :user_set
  belongs_to :flashcard
end
