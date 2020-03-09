class GroupMembership < ApplicationRecord
  belongs_to :language
  belongs_to :user
  belongs_to :group
end
