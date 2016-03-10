class UsersController < ApplicationController
  before_action :authenticate_user!
  layout "user"

  def index

  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end
end
