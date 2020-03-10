class UserSet < ApplicationRecord
  belongs_to :user
  belongs_to :card_set
  has_many :user_answers, dependent: :destroy
  has_many :flashcards, through: :user_answers
  has_many :group_memberships
  validates :completed, inclusion: {in: [true, false]}
  after_create :create_notifications
  after_update :create_notifications

  private

  def recipients
    # raise
    # memberships = GroupMembership.where(user: current_user)
    # groups = Group.where(language: self.card_set.language).to_set.superset?(self.to_set)

    # recipients = User.where(group_membership: membership)
  end

  def create_notifications
    # recipients.each do |recipient|
      # Notification.create(recipient: recipient, actor: current_user,
        # action: 'completed', notifiable: self)
    # end
  end
end
