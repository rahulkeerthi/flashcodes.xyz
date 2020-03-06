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
    @percentage = ((@correct.to_f / @flashcards.length) * 100).round
    @next_set = next_card_set
  end

  private

  # find current users most recent user set, which card set was last attempted
  def set_most_recent_user_set
    @most_recent_user_set = current_user.user_sets.order(last_attempted: :desc).first
  end

  # sort card sets by difficulty, this is for giving correct suggestion to user, which card set to try next after finishing a set
  def sort_by_difficulty(language)
    sorted = []
    difficulties = CardSet.select(:difficulty).distinct.map { |set| set.difficulty }
    difficulties.each do |difficulty|
      CardSet.where(language: language, difficulty: difficulty).each do |set|
        sorted << set
      end
    end
    sorted
  end

  # create a list/array of card sets the current user has not yet completed for given language
  def completed_sets(language)
    completed_user_sets = current_user.user_sets.select { |user_set| user_set.completed }
    completed_card_sets = completed_user_sets.map do |user_set|
      user_set.card_set if user_set.card_set.language == language
    end
  end

  # function to find correct next set suggestion to user
  # finds all card sets for a language, based on the last attempted card set
  # sorts the cards by difficulty and remove ones the user has already completed
  def next_card_set
    set_most_recent_user_set
    card_set = @most_recent_user_set.card_set
    language = card_set.language
    select = false
    # sets are cards sets sorted by difficulty, which not user has not yet completed
    # last attempted card set will be retained in the list, to find current proggress of user, even if he completed it
    sets = sort_by_difficulty(language) - (completed_sets(language) - [card_set])
    sets[sets.index(card_set) + 1] unless sets.count == 1 && @most_recent_user_set.completed
  end

end
