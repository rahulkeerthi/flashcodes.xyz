class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notifications, only: :index

  def index
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
  end

  private

  def set_notifications
    @notifications = Notification.where(recipient: current_user)
  end

end
