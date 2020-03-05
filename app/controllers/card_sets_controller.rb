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
      @user_set.last_attempted = Time.now
      @user_set.points_earned = 0
      @user_set.save
    else
      @user_set = UserSet.new(user: current_user, card_set: @card_set, completed: false, points_earned: 0)
      @user_set.last_attempted = Time.now
      @user_set.save
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
