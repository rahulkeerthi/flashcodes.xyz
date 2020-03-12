class LanguagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @languages = policy_scope(Language).order(name: :asc)
    current_user.nil? ? @top3 = [] : top3
  end

  private

  def top3
    user_sets = current_user.user_sets.order(updated_at: :desc)
    user_languages = []
    user_sets.each do |user_set|
      user_languages << user_set.card_set.language
    end
    @top3 = user_languages.uniq.first(3)
  end
end
