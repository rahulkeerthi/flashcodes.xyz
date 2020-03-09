class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  belongs_to :language
  validates :name, presence: true
end
