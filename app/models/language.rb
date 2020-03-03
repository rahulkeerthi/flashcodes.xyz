class Language < ApplicationRecord
  has_many :card_sets

  validates :name, :description, presence: true
end
