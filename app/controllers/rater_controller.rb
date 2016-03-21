class RaterController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]
      idea = Idea.find(params[:id])
      if current_user.id != idea.user.id
        Pusher.trigger('notification_channel', 'rated', {
          message: true,
          author: idea.user.id
        })
        noti = Notification.new(message: "#{current_user.fullname} rated your post", notification_type: 3, author: idea.user.id)
        noti.user = current_user
        noti.idea = idea
        noti.save!
      end
      render :json => true
    else
      render :json => false
    end
  end
end
