Rails.application.routes.draw do
  root to: 'home#index'
  get 'states/:country', to: 'application#states'
  get 'cities/:country/:state', to: 'application#cities'

  devise_for :users, path: 'user',
  module: :user,
    path_names: {
      sign_up: :signup,
      sign_in: :login,
      sign_out: :logout
      }
end
