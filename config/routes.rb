Rails.application.routes.draw do
  resources :languages, only: :index do
   resources :card_sets, only: :index
  end
  resources :user_answers, only: [:create, :update]
  devise_for :users
  root to: 'pages#home'

  resources :card_sets, only: :show
  resources :users, only: :show

  get 'results', to: 'pages#results'
end
