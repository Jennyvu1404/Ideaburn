class User::EntrepreneursController < ApplicationController
  before_action :authenticate_user!
  layout "idea"

  def index
    @entrepreneurs = User.entrepreneur.page(params[:page]).order('created_at desc')
  end
end
