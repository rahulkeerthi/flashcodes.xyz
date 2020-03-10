class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships
  belongs_to :language
  has_many :users, through: :group_memberships
  validates :name, presence: true
end
