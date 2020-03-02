class UserSet < ApplicationRecord
  belongs_to :user
  belongs_to :set
  has_many :user_answers
end
