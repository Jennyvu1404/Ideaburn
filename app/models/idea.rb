class Idea < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :likes
  has_many :notifications
  mount_uploader :attachment, UserUploader

  scope :by_keyword, -> (q){where("title LIKE '%#{q}%'")}

  validates :category_id, presence: true
  validates :title, presence: true
  validates :description, presence: true

  ratyrate_rateable 'visual_effects', 'original_score', 'director', 'custome_design'

  def category
    Category.find(self.category_id)
  end

  def like_per_views
    return 0 if self.likes.count.zero?
    self.likes.count / self.views
  end

  def total_rating
    Rate.where(rateable_type: "Idea", rateable_id: self.id).count
  end

  def rating
    total = Rate.where(rateable_type: "Idea", rateable_id: self.id).count
    total_stars = Rate.where(rateable_type: "Idea", rateable_id: self.id).sum(:stars)
    return total > 0 ? (( total_stars * 2 ) / total).round(1) : 0.0
  end
end
