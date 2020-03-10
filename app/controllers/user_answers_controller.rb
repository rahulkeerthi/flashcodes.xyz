class UserAnswersController < ApplicationController
  POINTS = {
      "Easy": 10,
      "Medium": 20,
      "Hard": 30,
      "Impossible": 50
    }

  def update
    flashcard = Flashcard.find(params[:user_answer][:flashcard])
    difficulty = flashcard.card_set.difficulty.to_sym
    user_set = UserSet.find(params[:user_answer][:user_set])
    answer = params[:user_answer][:answer]
    # group = GroupMembership.find_by(user: current_user, language: user_set.card_set.language)
    if answer == flashcard.correct_answer
      user_answer = UserAnswer.where(flashcard: flashcard, user_set: user_set).first
      unless user_answer.correct

        user_answer.correct = true
        user_answer.save
        # logic for adding points
        user_set.points_earned += POINTS[difficulty]
        current_user.points += POINTS[difficulty]
        current_user.save
        # logic to add earned points to group points
        # group.points += POINTS[difficulty]
        # group.save
      end
    end

    user_set.completed = user_set.user_answers.all? { |answer| answer.correct }
    user_set.save
  end

end
