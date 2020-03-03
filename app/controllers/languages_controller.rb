class LanguagesController < ApplicationController
  def index
    @languages = policy_scope(Language).order(name: :asc)
    top3
  end

  private

  def top3
    user_sets = current_user.user_sets.order(updated_at: :desc)
    user_languages = []
    user_sets.each do |user_set|
      user_languages << user_set.card_set.language.name
    end
    @top3 = user_languages.uniq.first(3)
  end
end
