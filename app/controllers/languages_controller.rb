class LanguagesController < ApplicationController
  def index
    user_sets = current_user.user_sets.order(updated_at: :desc)
    user_languages = []
    user_sets.each do |user_set|
      user_languages << user_set.card_sets.language.name
    end
    @top3 = user_languages.uniq!.first(3)
    @languages = policy_scope(Language)
  end
end
