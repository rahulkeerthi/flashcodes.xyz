Rails.application.routes.draw do
  devise_for :users
  resources :languages, only: :index do
   resources :card_sets, only: :index
  end
  resources :user_answers, only: [:create, :update]
  resources :card_sets, only: :show
  resources :users, only: :show
  root to: 'pages#home'

# FOR TESTING CSS AND STYLES
  get 'test', to: 'pages#test'

end
