class Api::IdeaController < ApplicationController
  before_action :get_idea, only: [:comments, :rating_page, :like_page]

  def comments
    @comments = @idea.comments.where(parent_id: nil).order(id: :desc).limit(params[:limit])
    render layout: false
  end

  def like_page
    render layout: false
  end

  def rating_page
    render layout: false
  end

  private

  def get_idea
    @idea = Idea.find(params[:id])
  end

end
