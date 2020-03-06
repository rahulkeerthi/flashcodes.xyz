class UserAnswersController < ApplicationController
  POINTS = {
      "Easy": 10,
      "Medium": 20,
      "Hard": 30
    }

  def update

    flashcard = Flashcard.find(params[:user_answer][:flashcard])
    difficulty = flashcard.card_set.difficulty.to_sym
    user_set = UserSet.find(params[:user_answer][:user_set])
    answer = params[:user_answer][:answer]
    if answer == flashcard.correct_answer
      user_answer = UserAnswer.where(flashcard: flashcard, user_set: user_set).first
      unless user_answer.correct
        user_answer.correct = true
        user_answer.save
        # logic for adding points
        user_set.points_earned += POINTS[difficulty]
        current_user.points += POINTS[difficulty]
        current_user.save
      end
    end

    user_set.completed = user_set.user_answers.all? { |answer| answer.correct }
    user_set.save
  end

end
