Rails.application.routes.draw do
  root to: 'home#index'

  devise_scope :user do
    get 'user/logout' => 'user/sessions#destroy'
  end
  devise_for :users, path: 'user',
  module: :user,
    path_names: {
      sign_up: :signup,
      sign_in: :login,
      sign_out: :logout
      }

  namespace :api do
    get 'states/:country', to: 'location#states'
    get 'cities/:country/:state', to: 'location#cities'
  end
end
