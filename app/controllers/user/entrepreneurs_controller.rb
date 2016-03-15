class User::EntrepreneursController < ApplicationController
  layout "idea"

  def index
    @entrepreneurs = User.entrepreneur.page(params[:page]).order('created_at desc')
  end
end
