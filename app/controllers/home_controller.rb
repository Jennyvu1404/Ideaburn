class HomeController < ApplicationController
  def index
    @entrepreneurs = User.entrepreneur.page(1).order('created_at desc')
  end
end
