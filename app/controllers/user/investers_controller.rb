class User::InvestersController < ApplicationController
  layout "application"

  def index
    @users = User.investor.page(params[:page]).order('created_at desc')
  end
end
