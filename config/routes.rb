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
end
