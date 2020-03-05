class UserAnswersController < ApplicationController
  def create
    # flashcard = Flashcard.find(params[:flashcard_id])
    # user_set = UserSet.find(card_set: flashcard.card_set, user: current_user)

    # @user_answer = UserAnswer.find_by(user_set: user_set, flashcard: flashcard)
    # raise
    # redirect_to "/results"

    # correct: flashcard.correct_answer == user_answer_params[:answer]
    # answer: user_answer_params[:answer]


    # @user_answer = UserAnswer.where(user_set: user_set, flashcard: flashcard).first_or_create do |user_answer|
    #   user_answer = params[:user_answer][:answer]
    #   user_answer.correct = flashcard.correct_answer == user_answer
    #   raise

    # end
  end

  def update
    @user_answer = UserAnswer.find(params[:id])
    @user_answer.update(user_answer_params)
    @user_answer.correct = @user_answer.flashcard.correct_answer == user_answer_params[:answer]
    @user_answer.save
    redirect_to card_set_path(@user_answer.user_set.card_set)
  end

  def index
  end

  private

  def user_answer_params
    params.require(:user_answer).permit(:answer)
  end
end
