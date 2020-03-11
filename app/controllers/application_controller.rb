class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_footer_languages, :test_langs, :authenticate_user!
  before_action :user_level, if: :user_signed_in?
  before_action :set_notifications, if: :user_signed_in?
  before_action :set_level_names

  include Pundit

  # LEVEL THRESHOLD
  LEVEL_THRESHOLD = 500
  LEVEL_NAMES = {
    1 =>"Village",
    2 => "Town",
    3 => "City",
    4 => "Planet"
  }


  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def default_url_options
    { host: ENV["flashcodes.xyz"] || "localhost:3000" }
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def set_footer_languages
    @footerlangs = policy_scope(Language.all.limit(8))
  end

  def test_langs
    @testlangs2 = Language.all.to_a.each_slice(3)
  end

  def user_level
    user_points = current_user.points
    @level =  1 + user_points / LEVEL_THRESHOLD
    @level_percentage = (user_points%LEVEL_THRESHOLD.to_f / LEVEL_THRESHOLD) * 100
  end


  private

  def set_level_names
    @level_names = LEVEL_NAMES
  end

  def set_notifications
    @notifications = Notification.where(recipient: current_user)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :photo]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
