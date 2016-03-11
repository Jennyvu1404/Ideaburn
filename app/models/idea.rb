class Idea < ActiveRecord::Base

  belongs_to :user
  mount_uploader :attachment, UserUploader

  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
end
