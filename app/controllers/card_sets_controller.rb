class CardSetsController < ApplicationController
  def index
    @language = policy_scope(Language).find(params[:language_id])
    @easy_sets = CardSet.where(language: @language, difficulty: "Easy")
    @medium_sets = CardSet.where(language: @language, difficulty: "Medium")
    @hard_sets = CardSet.where(language: @language, difficulty: "Hard")
    @user_sets = current_user.user_sets if signed_in?
    @temp
  end

  def show
    @answer = UserAnswer.new
    @card_set = CardSet.find(params[:id])
    @user_set = UserSet.where(card_set: @card_set, user: current_user).first_or_create do |user_set|
      user_set.completed = false
    end
    @flashcard_set = @card_set.flashcards
    # @flashcard_set = @flashcard_set.shuffle
  end
end
