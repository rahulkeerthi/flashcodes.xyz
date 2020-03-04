class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_user_set, only: :results
  before_action :next_card_set, only: :results

  def home
  end

  def results
    @card_set = @user_set.card_set
    @correct = @user_set.user_answers.count { |answer| answer.correct == true }
    @incorrect = @most_recent_user_set.user_answers.count { |answer| answer.correct == false }
    @flashcards = @most_recent_user_set.card_set.flashcards
    @percentage = (@correct.to_f / @flashcards.length) * 100
  end

  private

  def set_user_set
    @most_recent_user_set = current_user.user_sets.order(updated_at: :asc).first
  end

  def next_card_set
    @next_set = UserSet.create(card_set: CardSet.find(UserSet.first.card_set.id+1), user: current_user,completed: false)
  end
end
