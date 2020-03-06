class CardSetsController < ApplicationController
  def index
    @difficulty_value = 0
    @language = Language.find(params[:language_id])
    if params[:query].blank?
      @card_sets = CardSet.where(language: @language)
    else
      @card_sets = CardSet.search_by_title_and_description(params[:query]).select{ |set| set.language == @language }
      @card_sets = CardSet.where(language: @language) if @card_sets.blank?
    end

    @difficulties = CardSet.select(:difficulty).distinct.map { |set| set.difficulty }
    # ["Easy", "Medium", "Hard"]
    @user_sets = current_user.user_sets if signed_in?
    @temp
  end

  def show
    @answer = UserAnswer.new
    set_card_set
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
    end
  end

  private

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

end
