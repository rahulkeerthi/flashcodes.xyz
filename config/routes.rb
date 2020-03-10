Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
  resources :users, only: :show
  resources :user_answers, only: :create
  patch 'user_answers', to: 'user_answers#update'

  # STANDALONE ROUTES
  root to: 'pages#home'
  get 'results', to: 'pages#results'
  get 'social', to: 'pages#social'

  # FOR TESTING CSS AND STYLES
  get 'test', to: 'pages#test'
  get 'languages/:language_id/search/', to: 'card_sets#search', as: 'search'
end
