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
        user_set.save
        current_user.points += POINTS[difficulty]
        current_user.save
        # logic to add earned points to group points
        membership.points += POINTS[difficulty]
        membership.save
        if (group.group_memberships.calculate(:sum, :points)) >= group.target_points
          # limit max level and level incrementation
          unless group.level >= 4
            group.level += 1
            group.target_points += BASE_LEVEL_PTS * group.level
            group.save
            group.users.each do |recipient|
              Notification.create(
                recipient: recipient,
                actor: current_user,
                content: "#{group.name} has leveled up while learning #{group.language}! New level: #{@level_names[group.level]}")
            end
          end
        end
      end
    end

    if user_set.user_answers.all? { |answer| answer.correct }
      user_set.completed = true
      user_set.save
      # creating recipients for the notifications, substracting the current user, put into an array so that we can substract from the users array
      group.users.each do |recipient|
        unless recipient == current_user
          Notification.create(
            recipient: recipient,
            actor: current_user,
            action: card_set_path(user_set.card_set),
            content: "#{current_user.username.capitalize} has completed the #{user_set.card_set.title} set.")
        end
      end
    end
  end

end
