Rails.application.routes.draw do
  # DEVISE ROUTES
  devise_for :users

  # NESTED ROUTES
  resources :languages, only: :index do
   resources :card_sets, only: :index
  end
  resources :card_sets, only: :show do
    resources :user_sets, only: [:create, :update]
  end

  # UN-NESTED ROUTES
  resources :user_answers, only: [:create, :update]
  resources :users, only: :show

  # STANDALONE ROUTES
  root to: 'pages#home'
  get 'results', to: 'pages#results'

  # FOR TESTING CSS AND STYLES
  get 'test', to: 'pages#test'
end
