class User::EntrepreneursController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  layout :layout_by_action

  def index
    @users = User.entrepreneur.page(params[:page]).order('created_at desc')
  end

  def show
    @user = User.find(params[:id])
    if @user.entrepreneur?
      @info = @user.entrepreneur
    end
  end

  private

  def layout_by_action
    action_name == "show" ?  "idea" : "application"
  end

end
