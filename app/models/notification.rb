class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  enum notification_type: {commented: 1, liked: 2, rated: 3}
end

