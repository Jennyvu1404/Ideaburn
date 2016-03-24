class Api::NotificationController < ApplicationController
  def index
     @notification =  Notification.by_user_id(current_user.id)
     render layout: false
  end

  def seen
    Notification.seen_all_user_notifications(current_user.id)
    render json: true
  end
end
