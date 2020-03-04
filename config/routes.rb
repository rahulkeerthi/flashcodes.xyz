Rails.application.routes.draw do
  resources :languages, only: :index do
   resources :card_sets, only: [:index, :show]
  end
  resources :user_answers, only: [:create, :update, :index]
  devise_for :users
  root to: 'pages#home'
  resources :users, only: :show

# FOR TESTING CSS AND STYLES
  get 'test', to: 'pages#test'

end
