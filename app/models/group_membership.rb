class GroupMembership < ApplicationRecord
  belongs_to :language
  belongs_to :user
  belongs_to :group

  after_create :create_notifications


  private

  def recipients
    raise
    self.group.group_memberships.map { |membership| membership.user } - self
  end

  def create_notifications
    recipients.each do |recipient|
      Notification.create(recipient: recipient, actor: current_user,
        action: 'posted', notifiable: self)
    end
  end
end
