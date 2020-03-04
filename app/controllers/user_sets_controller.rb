class UserSetsController < ApplicationController
  def create
    @card_set = CardSet.find(params[:card_set_id])
    @user_set = UserSet.find_by(card_set: @card_set, user: current_user)
    unless @user_set
      @user_set = UserSet.create(card_set: @card_set, user: current_user, completed: false)
      @card_set.flashcards.each do |flashcard|
        UserAnswer.create!(user_set: @user_set, flashcard: flashcard, correct: false)
      end
    end
    redirect_to card_set_path(@card_set)
  end

  def update
  end

  def index
  end
end
