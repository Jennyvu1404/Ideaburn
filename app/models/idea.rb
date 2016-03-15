class Idea < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  mount_uploader :attachment, UserUploader

  scope :by_keyword, -> (q){where("title LIKE '%#{q}%'")}

  validates :category_id, presence: true
  validates :title, presence: true
  validates :description, presence: true

  def category
    Category.find(self.category_id)
  end
end
