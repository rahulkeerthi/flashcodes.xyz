Rails.application.routes.draw do
  resources :languages, only: :index do
    resources :card_sets, only: :index
  end
  get 'user_answers/create'
  get 'user_answers/update'
  get 'user_answers/index'
  get 'sets/index'
  get 'sets/show'
  devise_for :users
  root to: 'pages#home'
end
