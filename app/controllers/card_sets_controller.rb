class CardSetsController < ApplicationController
  def index
    @language = Language.find(params[:language_id])
    @easy_sets = CardSet.where(language: @language, difficulty: "easy")
    @medium_sets = CardSet.where(language: @language, difficulty: "medium")
    @hard_sets = CardSet.where(language: @language, difficulty: "hard")
  end

  def show
  end
end
