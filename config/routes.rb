Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/entrepreneur'
  get 'users/myacount'

  devise_for :users, path: 'user',
  module: :user,
    path_names: {
      sign_up: :signup,
      sign_in: :login,
      sign_out: :logout
  }
  devise_scope :user do
    get 'user/logout' => 'user/sessions#destroy'
  end
  resources :users

  namespace :api do
    get 'states/:country', to: 'location#states'
    get 'cities/:country/:state', to: 'location#cities'
    get 'subregion_options', to: 'location#subregion_options'
    get 'idea/comments/:id', to: 'idea#comments'
    get 'notifications/all', to: 'notification#index'
  end

  namespace :user do
    resources :ideas do
      collection do
        post '/comment' => 'ideas#create_comment'
        post '/reply' => 'ideas#create_reply'
        post '/like' => 'ideas#like'
      end
    end
  end
  get 'entrepreneurs' => 'user/entrepreneurs#index'
  get 'entrepreneur/:id', to: 'user/entrepreneurs#show', as: 'entrepreneur'
  get 'investers' => 'user/investers#index'
  get 'startups' => 'user/startups#index'
end
