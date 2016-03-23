class Api::NotificationController < ApplicationController
  def index
     @notification =  Notification.get_noti
     render layout: false
  end

  def seen
    Notification.seen
    render json: true
  end
end
