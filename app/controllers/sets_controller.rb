class SetsController < ApplicationController
  def index
    @language = Language.find(params[:id])
    @easy_sets = Card_set.where(language: @language, difficulty: "easy")
    @intermediate_sets = Card_set.where(language: @language, difficulty: "intermediate")
    @hard_sets = Card_set.where(language: @language, difficulty: "hard")
  end

  def show
  end
end
