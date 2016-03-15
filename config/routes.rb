Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, path: 'user',
  module: :user,
    path_names: {
      sign_up: :signup,
      sign_in: :login,
      sign_out: :logout
      }
  resources :users
  namespace :api do
    get 'states/:country', to: 'location#states'
    get 'cities/:country/:state', to: 'location#cities'
    get 'subregion_options', to: 'location#subregion_options'
  end
  namespace :user do
  resources :ideas
  end
end
