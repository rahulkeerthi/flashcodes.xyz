class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notifications, only: :index

  def index
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    render template: "pages/test"
  end

  private

  def set_notifications
    @notifications = Notification.where(recipient: current_user).unread
  end

end
