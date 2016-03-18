class User::StartupsController < ApplicationController
  layout "application"

  def index
    @users = User.startup.page(params[:page]).order('created_at desc')
  end
end
