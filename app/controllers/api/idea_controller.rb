class Api::IdeaController < ApplicationController
  before_action :get_idea, only: [:comments]

  def comments
    render layout: false
  end

  private

  def get_idea
    @idea = Idea.find(params[:id])
  end
end
