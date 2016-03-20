class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea
  has_many :comments, foreign_key: :parent_id
end
