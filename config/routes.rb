Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/entrepreneur'
  get 'users/myacount'
  get 'users/notification'

  devise_for :users, path: 'user',
  module: :user,
    path_names: {
      sign_up: :signup,
      sign_in: :login,
      sign_out: :logout
  }
  devise_scope :user do
    get 'user/logout' => 'user/sessions#destroy'
    get 'user/my_acount' => 'user/registrations#edit_password', as: 'my_acount'
    post 'user/update_password' => 'user/registrations#update_password'
    get 'user/notification' => 'user/registrations#notification', as: 'notification'
    get 'user/message' => 'user/registrations#message', as: 'message'
    get 'user/unread' => 'user/registrations#unread', as:'unread'
    get 'user/loadmorenotification' => 'user/registrations#loadmorenotification', as:'loadmorenotification'
  end
  resources :users

  namespace :api do
    get 'states/:country', to: 'location#states'
    get 'cities/:country/:state', to: 'location#cities'
    get 'subregion_options', to: 'location#subregion_options'
    get 'idea/comments/:id/:limit', to: 'idea#comments'
    get 'notifications/all', to: 'notification#index'
    get 'notifications/seen', to: 'notification#seen'
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
  post '/rate' => 'rater#create', :as => 'rate'
end
