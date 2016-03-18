class User::IdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_entrepreneur!
  layout 'idea'
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  # GET /ideas
  # GET /ideas.json
  def index
    if params[:q]
      ideas = current_user.ideas.by_keyword(params[:q])
    else
      ideas = current_user.ideas
    end
    @ideas = ideas.page(params[:page]).order('created_at desc')
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea.update_attributes(views: @idea.views + 1)
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = current_user.ideas.build(idea_params)

    respond_to do |format|
      if @idea.save
        format.html { redirect_to user_ideas_path, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @idea = Idea.find(params[:idea_id])
    if params[:status].to_i.zero?
      current_user.likes.where(idea_id: @idea.id).delete_all
    else
      like = current_user.likes.where(idea_id: @idea.id).first_or_create
      like.save
      Pusher.trigger('notification_channel', 'like', {
        message: "#{current_user.fullname} liked your post",
        author: @idea.user.id,
        commenter: current_user.id,
        commenterAvatar: ActionController::Base.helpers.asset_path(current_user.avatar),
        idea: @idea.attachment
      })
    end
    render 'user/ideas/_like', layout: false
  end

  def create_comment
    @comment = current_user.comments.build(idea_id: params[:idea_id], message: params[:message])
    @comment.save
    Pusher.trigger('notification_channel', 'comment', {
      message: "#{current_user.fullname} commented on your post",
      author: @comment.idea.user.id,
      commenter: current_user.id,
      commenterAvatar: ActionController::Base.helpers.asset_path(current_user.avatar),
      idea: @comment.idea.attachment
    })
    render 'user/ideas/_comment', layout: false
  end

  def create_reply
    comment = current_user.comments.find(params[:comment_id])
    @comment = comment.dup
    @comment.update_attributes(user_id: current_user.id, message: params[:message], parent_id: comment.id)
    render 'user/ideas/_reply', layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:category_id, :title, :description, :attachment)
    end

    def authenticate_entrepreneur!
      redirect_to root_path unless current_user.entrepreneur?
    end
  end
