class UserSet < ApplicationRecord
  belongs_to :user
  belongs_to :card_set
  has_many :user_answers, dependent: :destroy
  has_many :flashcards, through: :user_answers
  validates :completed, inclusion: {in: [true, false]}

  after_update :create_notifications

  private

  def recipients
    self.group.group_memberships.map { |membership| membership.user } - self
    raise
  end

  def create_notifications
    recipients.each do |recipient|
      Notification.create(recipient: recipient, actor: current_user,
        action: 'posted', notifiable: self)
    end
  end
end
