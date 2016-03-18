class Api::NotificationController < ApplicationController
  def index
     @notification =  Notification.where(idea_id: current_user.id).order(id: 'desc')
     render layout: false
  end
end
