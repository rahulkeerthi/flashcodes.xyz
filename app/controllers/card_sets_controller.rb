require 'faker'

class CardSetsController < ApplicationController
  before_action :motivation, only: :index
  def index
    @difficulty_value = 0
    @language = Language.find(params[:language_id])
    # sets the group to
    if params[:query].blank?
      @card_sets = CardSet.where(language: @language)
    else
      @card_sets = CardSet.search_by_title_and_description(params[:query]).select{ |set| set.language == @language }
      @card_sets = CardSet.where(language: @language) if @card_sets.blank?
    end

    @difficulties = CardSet.select(:difficulty).distinct.map { |set| set.difficulty }
    # ["Easy", "Medium", "Hard"]
    @user_sets = current_user.user_sets if user_signed_in?
    @temp
  end

  def show
    @answer = UserAnswer.new
    set_card_set
    @count = @card_set.flashcards.count
    @counter = @count
    # Check if the user has previously attempted the selected card set
    # Load the corresponding user set if attempted? returns true and resets points earned
    # points are reset so that we only hold points earned from current run
    if attempted?
      @user_set = UserSet.where(card_set: @card_set, user: current_user).first
      @user_set.last_attempted = Time.now
      @user_set.points_earned = 0
      @user_set.save
    # if not attempted before, create a new user set for the selected card set and generate correct number of unser answers, all set to false
    else
      @user_set = UserSet.new(user: current_user, card_set: @card_set, completed: false, points_earned: 0)
      @user_set.last_attempted = Time.now
      @user_set.save
      generate_user_answers(@user_set)
      assign_user_to_free_group
    end
  end

  private

  def motivation
  # this method sets the friends and motivationbox depending on the members of your group and who has done it
    @language = Language.find(params[:language_id])
    @group = current_user.groups.find_by(language: @language)
    @text = "Hello"
  end

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

  def assign_user_to_free_group
    current_language = @user_set.card_set.language
    matches = current_user.user_sets.select { |set| set.card_set.language == current_language }
    # check if user has completed any sets in this language before
    # should be equal to 1 if first time trying a card set for this language
    if matches.count == 1
      # if not, then find last created group in that language that has less than 10 users
      group = Group.find_by(language: current_language, full: false)
      if group.nil?
      # if no free group exists, create group and add user to that group (via a group membership)
        new_group = Group.create(name: "#{Faker::Coffee.blend_name} #{Faker::Creature::Animal.name}s", language: current_language, full: false)
        GroupMembership.create(group: new_group, user: current_user)
      else
        # Only for existing groups, set recipients for notification based on group memberships
        recipients = group.users # before current user added
        membership = GroupMembership.create(group: group, user: current_user, points: 0)
        group.full = group.group_memberships.count == 10
        group.save
        send_notifications(recipients, group)
      end
    end
  end

  # Iterate over recipients to create a new notification
  def send_notifications(recipients, group)
    recipients.each do |recipient|
      Notification.create!(recipient: recipient,
        content: "#{current_user.username.capitalize} has joined your group, #{group.name}.", sender: current_user)
      raise
    end
  end

end
