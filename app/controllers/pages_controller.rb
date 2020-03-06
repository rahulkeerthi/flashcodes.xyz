class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_most_recent_user_set, only: :results

  def home
    if user_signed_in?
      redirect_to languages_path
    end
  end

  def test
  end

  def results
    @card_set = @most_recent_user_set.card_set
    @correct = @most_recent_user_set.user_answers.where(correct: true).count
    @incorrect = @card_set.flashcards.count - @correct
    @flashcards = @most_recent_user_set.card_set.flashcards
    @percentage = (@correct.to_f / @flashcards.length) * 100
    @next_set = next_card_set.first
  end

  private

  def set_most_recent_user_set
    @most_recent_user_set = current_user.user_sets.order(last_attempted: :desc).first
  end

  def sort_by_difficulty(language)
    sorted = []
    difficulties = ["Easy", "Medium", "Hard"]
    difficulties.each do |difficulty|
      CardSet.where(language: language, difficulty: difficulty).each do |set|
        sorted << set
      end
    end
    sorted
  end

  def complete(language)
    completed_user_sets = current_user.user_sets.select { |user_set| user_set.completed }
    completed_card_sets = completed_user_sets.map do |user_set|
      user_set.card_set if user_set.card_set.language == language
    end
  end

  def next_card_set
    set_most_recent_user_set
    card_set = @most_recent_user_set.card_set
    language = card_set.language
    select = false
    sets = sort_by_difficulty(language) - complete(language)
    # if sets.empty? ## logic for when we have completed all sets for current language
    sets.each do |set|
      return next_set = set if select
      select = true if set == card_set
    end
  end

end
