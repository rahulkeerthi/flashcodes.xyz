class Language < ApplicationRecord
  has_many :card_sets
  has_one_attached :photo

  validates :name, :description, presence: true
end
