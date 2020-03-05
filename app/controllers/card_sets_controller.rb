class CardSetsController < ApplicationController
  def index
    @language = policy_scope(Language).find(params[:language_id])
    @difficulties = ["Easy", "Medium", "Hard"]
    @user_sets = current_user.user_sets if signed_in?
    @temp
  end

  def show
    @answer = UserAnswer.new
    set_card_set
    # @user_set = UserSet.where(card_set: @card_set, user: current_user).first_or_create { |user_set| user_set.completed = false }
    if attempted?
      @user_set = UserSet.where(card_set: @card_set, user: current_user).first
    else
      @user_set = UserSet.create(user: current_user, card_set: @card_set, completed: false)
      generate_user_answers(@user_set)
    end
  end

  private

  def set_card_set
    @card_set = CardSet.find(params[:id])
  end

  def attempted?
    set_card_set
    !UserSet.where(card_set: @card_set, user: current_user).first.blank?
  end

  def generate_user_answers(user_set)
    user_set.card_set.flashcards.each do |card|
      new_answer = UserAnswer.create(correct: false, flashcard: card, user_set: user_set)
    end
  end

end
