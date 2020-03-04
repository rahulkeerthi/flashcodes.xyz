class UserAnswersController < ApplicationController
  def create
    param
    @user_answer = UserAnswer.new
    @user_answer.user = current_user
    @user_answer.flashcard = Flashcard.find(params)
    redirect_to "/results"
  end

  def update
  end

  def index
  end
end
