class Idea < ActiveRecord::Base

  belongs_to :user
  belongs_to :category, foreign_key: 'category_id'
  mount_uploader :attachment, UserUploader

  validates :category_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
