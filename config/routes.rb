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
  end

  namespace :user do
    resources :ideas do
      collection do
        post '/comment' => 'ideas#create_comment'
        post '/reply' => 'ideas#create_reply'
        post '/like' => 'ideas#like'
      end
    end
    get 'entrepreneur', to: 'users#entrepreneur'
  end
end
