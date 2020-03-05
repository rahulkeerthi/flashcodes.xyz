Rails.application.routes.draw do
  resources :languages, only: :index do
   resources :card_sets, only: :index
  end
  resources :user_answers, only: :create
  patch 'user_answers', to: 'user_answers#update'
  devise_for :users
  root to: 'pages#home'

  resources :card_sets, only: :show do
    resources :user_sets, only: [:create, :update]
  end
  resources :users, only: :show

  get 'results', to: 'pages#results'
end
