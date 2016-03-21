class Api::NotificationController < ApplicationController
  def index
     @notification =  Notification.where(author: current_user.id).order(id: 'desc')
     render layout: false
  end

  def seen
    Notification.where(author: current_user.id).update_all(seen: true)
    render json: true
  end
end
