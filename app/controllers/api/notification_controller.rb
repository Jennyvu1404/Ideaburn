class Api::NotificationController < ApplicationController
  def index
     @notification =  Notification.where(author: current_user.id).order(id: 'desc')
     render layout: false
  end
end
