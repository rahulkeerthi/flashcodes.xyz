class GroupMembership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  # after_create :create_notifications


  private

  # def recipients
  #   membership = current_user.group_memberships
  #   groups = Group.where(language: self.card_set.language).to_set.superset?(self.to_set)

  #   recipients = User.where(group_membership: membership)
  # end

  # def create_notifications
  #   recipients.each do |recipient|
  #     Notification.create(recipient: recipient, actor: current_user,
  #       action: 'joined', notifiable: self)
  #   end
  # end
end
