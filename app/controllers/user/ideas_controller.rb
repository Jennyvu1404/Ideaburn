class User::IdeasController < ApplicationController
  before_action :authenticate_user!
  layout 'idea'
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  # GET /ideas
  # GET /ideas.json
  def index
    ideas = Idea.all
    ideas = ideas.by_keyword(params[:q]) if params[:q].present?
    ideas = ideas.by_category(params[:c]) if params[:c].present?
    ideas = ideas.by_country(params[:country])if params[:country].present?
    ideas = ideas.by_category(params[:c]) if params[:c].present?
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
      if current_user.id != @idea.user.id
        Pusher.trigger('notification_channel', 'liked', {
          message: true,
          author: @idea.user.id
        })
        noti = Notification.new(message: "#{current_user.fullname} liked your post", notification_type: 2, author: @idea.user.id)
        noti.user = current_user
        noti.idea = @idea
        noti.save!
      end
    end
    render 'user/ideas/_like', layout: false
  end

  def create_comment
    @comment = current_user.comments.build(idea_id: params[:idea_id], message: params[:message])
    @comment.save
    if current_user.id != @comment.idea.user.id
      Pusher.trigger('notification_channel', 'commented', {
        message: true,
        author: @comment.idea.user.id
      })
      noti = Notification.new(message: "#{current_user.fullname} commented on your post", notification_type: 1, author: @comment.idea.user.id)
      noti.user = current_user
      noti.idea = @comment.idea
      noti.save!
    end
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
