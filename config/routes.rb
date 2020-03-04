Rails.application.routes.draw do
  # DEVISE ROUTES
  devise_for :users

  # LANGUAGES AND THEIR CARD SETS
  resources :languages, only: :index do
   resources :card_sets, only: :index
  end

  # UN-NESTED ROUTES
  resources :user_answers, only: [:create, :update]
  resources :card_sets, only: :show
  resources :users, only: :show

  # STANDALONE ROUTES
  root to: 'pages#home'
  get 'results', to: 'pages#results'

  # FOR TESTING CSS AND STYLES
  get 'test', to: 'pages#test'
end
