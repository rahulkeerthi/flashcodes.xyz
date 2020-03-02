class UserSet < ApplicationRecord
  belongs_to :user
  belongs_to :card_set
  has_many :user_answers
end
