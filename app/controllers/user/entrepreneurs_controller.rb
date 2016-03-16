class User::EntrepreneursController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @users = User.entrepreneur.page(params[:page]).order('created_at desc')
  end

end
