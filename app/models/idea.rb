class Idea < ActiveRecord::Base

  mount_uploader :attachment, UserUploader
end
