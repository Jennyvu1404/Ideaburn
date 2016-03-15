class User::EntrepreneursController < ApplicationController
  layout "application"

  def index
    @users = User.entrepreneur.page(params[:page]).order('created_at desc')
  end
end
