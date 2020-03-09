class Group < ApplicationRecord
  has_many :group_memberships
  validates :name, presence: true
end
