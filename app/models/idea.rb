class Idea < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :likes
  has_many :notifications
  mount_uploader :attachment, UserUploader

  scope :by_keyword, -> (q){where("title LIKE '%#{q}%'")}
  scope :by_category, -> (c){where(:category_id => c)}
  scope :by_country, -> (c){joins(:user).where("users.country" => c)}
  scope :by_country_category, -> (country, c){joins(:user).where("users.country" => country, :category_id => c)}

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

  def like_description
    if self.likes.count.zero?
      description = "Be the first like this"
    elsif self.likes.count == 1
      description =  "<span style='color:#78C2E9;cursor:pointer;'>#{self.likes.first.user.fullname}</span> likes this".html_safe
    else
      offset = rand(self.likes.count)
      description = "<span style='color:#78C2E9;cursor:pointer;'>#{self.likes.offset(offset).first.user.fullname}</span> and #{self.likes.count - 1} others likes this".html_safe
    end
  end
end
