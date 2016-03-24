class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  enum notification_type: {commented: 1, liked: 2, rated: 3}
  scope :by_user_id, lambda{|id| where(author: id).order(id: 'desc')}
  scope :user_unread_notifications, lambda{|id| where(author: id, seen: false).order(id: 'desc')}
  scope :seen_all_user_notifications, lambda{|id| where(author: id).update_all(seen: true)}
  # def self.notifications_of_user
  #   Notification.where(author: current_user.id).order(id: 'desc')
  # end
  # def self.user_unread_notifications
  #   Notification.where(author: current_user.id, seen: false).order(id: 'desc')
  # end
  # def self.seen_all_notifications_of_user
  #   Notification.where(author: current_user.id).update_all(seen: true)
  # end
end

