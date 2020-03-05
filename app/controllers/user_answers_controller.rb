class UserAnswersController < ApplicationController

  #def update
  #  raise
  #  @user_answer = UserAnswer.find(params[:id])
  #  @user_answer.update(user_answer_params)
  #  @user_answer.correct = @user_answer.flashcard.correct_answer == user_answer_params[:answer]
  #  @user_answer.save
  #  redirect_to card_set_path(@user_answer.user_set.card_set)
  #end

  def update
    flashcard = Flashcard.find(params[:user_answer][:flashcard])
    user_set = UserSet.find(params[:user_answer][:user_set])
    answer = params[:user_answer][:answer]
    if answer == flashcard.correct_answer
      user_answer = UserAnswer.where(flashcard: flashcard, user_set: user_set).first
      user_answer.correct = true
      user_answer.save
    end

    user_set.completed = user_set.user_answers.all? { |answer| answer.correct }
    user_set.save
  end

  #def index
  #end

  #private

  #def user_answer_params
  #  params.require(:user_answer).permit(:answer)
  #end
end
