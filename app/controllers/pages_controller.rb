class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_most_recent_user_set, only: [:results, :nudge]

  def home
    if user_signed_in?
      redirect_to languages_path
    end
  end

  def test
  end

  def social
  end

  def results
    @card_set = @most_recent_user_set.card_set
    @correct = @most_recent_user_set.user_answers.where(correct: true).count
    @incorrect = @card_set.flashcards.count - @correct
    @flashcards = @most_recent_user_set.card_set.flashcards
    @percentage = ((@correct.to_f / @flashcards.length) * 100).round
    @next_set = next_card_set
    @membership = current_user.group_memberships.select { |membership| membership.group.language == @card_set.language }.first
    @group = @membership.group
    @group_points = group_points
    @progress = ((@group_points - progress_points(@group)).to_f/(@group.target_points - progress_points(@group)))*550
    @level = LEVEL_NAMES[@group.level]
    @next_level = LEVEL_NAMES[@group.level+1]
    @nudge_users = filter_group_members
  end

  def nudge
    card_set = @most_recent_user_set.card_set
    recipient = User.find(params[:id])
    Notification.create(
      recipient: recipient,
      actor: current_user,
      action: card_set_path(card_set),
      content: "#{current_user.username.capitalize} has nudged you to do the #{card_set.title} set.")
  end

  private

  def progress_points(group)
    5000 * (@group.level - 1)
  end

  # returns group points by calculating how many points each of the members earned for the group
  def group_points
    @group.group_memberships.calculate(:sum, :points)
  end

  # find current users most recent user set, which card set was last attempted
  def set_most_recent_user_set
    @most_recent_user_set = current_user.user_sets.order(last_attempted: :desc).first
  end

  # sort card sets by difficulty, this is for giving correct suggestion to user, which card set to try next after finishing a set
  def sort_by_difficulty(language)
    sorted = []
    difficulties = CardSet.select(:difficulty).distinct.map { |set| set.difficulty }
    difficulties.each do |difficulty|
      CardSet.where(language: language, difficulty: difficulty).each do |set|
        sorted << set
      end
    end
    sorted
  end

  # create a list/array of card sets the current user has not yet completed for given language
  def completed_sets(language)
    completed_user_sets = current_user.user_sets.select { |user_set| user_set.completed }
    completed_card_sets = completed_user_sets.map do |user_set|
      user_set.card_set if user_set.card_set.language == language
    end
  end

  # function to find correct next set suggestion to user
  # finds all card sets for a language, based on the last attempted card set
  # sorts the cards by difficulty and remove ones the user has already completed
  def next_card_set
    set_most_recent_user_set
    card_set = @most_recent_user_set.card_set
    language = card_set.language
    # sets are cards sets sorted by difficulty, which not user has not yet completed
    # last attempted card set will be retained in the list, to find current proggress of user, even if he completed it
    sets = sort_by_difficulty(language) - (completed_sets(language) - [card_set])
    index = (sets.index(card_set) + 1) == sets.count ? 0 : (sets.index(card_set) + 1)
    sets[index] unless sets.count == 1 && @most_recent_user_set.completed
  end

  # method to filter out group members for nudge
  # only members of current users group who haven't completed the set yet
  def filter_group_members
    members = []
    @group.users.each do |user|
      unless user == current_user
        user_set = user.user_sets.find_by(card_set: @card_set)
        members << user if user_set.nil? || !user_set.completed
      end
    end
    members
  end

end
