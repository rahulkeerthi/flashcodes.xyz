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
    # find the membership where the language matches with the language of the set
    membership = current_user.group_memberships.select { |membership| membership.group.language == user_set.card_set.language }.first
    group = membership.group
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
        membership.points += POINTS[difficulty]
        membership.save
        if (group.group_memberships.calculate(:sum, :points)) >= group.target_points
          group.level += 1
          group.target_points += 5000 * group.level
          group.save
        end
      end
    end

    user_set.completed = user_set.user_answers.all? { |answer| answer.correct }
    user_set.save
  end

end
