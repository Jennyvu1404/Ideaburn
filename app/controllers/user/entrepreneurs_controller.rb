class User::EntrepreneursController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  layout :layout_by_action

  def index
    @users = User.entrepreneur.page(params[:page]).order('created_at desc')
  end

  def show
    @user = User.find(params[:id])
    @info = @user.entrepreneur
    ideas = current_user.ideas
    @ideas = ideas.page(params[:page]).order('created_at desc')
  end

  private

  def layout_by_action
    action_name == "show" ?  "user" : "application"
  end

end
