class Language < ApplicationRecord
  has_many :card_sets
  has_many :groups
  has_one_attached :photo

  validates :name, :description, presence: true
end
