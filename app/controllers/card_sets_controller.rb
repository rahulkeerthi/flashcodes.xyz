class CardSetsController < ApplicationController

  def index
    @language = policy_scope(Language).find(params[:language_id])
    @easy_sets = CardSet.where(language: @language, difficulty: "Easy")
    @medium_sets = CardSet.where(language: @language, difficulty: "Medium")
    @hard_sets = CardSet.where(language: @language, difficulty: "Hard")
    @user_sets = current_user.user_sets if signed_in?
    @temp
  end

  def show
  end
end
