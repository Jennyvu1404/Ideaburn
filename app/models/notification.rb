class Notification < ActiveRecord::Base
  cattr_accessor :current_user
  belongs_to :user
  belongs_to :idea

  enum notification_type: {commented: 1, liked: 2, rated: 3}
  def self.get_noti
    Notification.where(author: current_user.id).order(id: 'desc')
  end
  def self.get_unread
    Notification.where(author: current_user.id, seen: false).order(id: 'desc')
  end
  def self.seen
    Notification.where(author: current_user.id).update_all(seen: true)
  end
end

