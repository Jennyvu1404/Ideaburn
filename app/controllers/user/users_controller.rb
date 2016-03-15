class User::UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'idea'

  def entrepreneur
    @entrepreneurs = User.entrepreneur.page(params[:page]).order('created_at desc')
  end

end
