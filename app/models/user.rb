class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :ideas
  has_many :comments
  has_many :likes
  has_one :startup, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :startup, reject_if: proc { |attributes| attributes['name'].blank? },
  allow_destroy: true

  has_one :investor, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :investor, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true

  has_one :entrepreneur, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :entrepreneur, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true

  enum user_type: {admin: 1, entrepreneur: 2, startup: 3, investor: 4}

  validates :username, presence: true, length: { minimum: 5 }
  validates :user_type, presence: true
  validates :password, presence: true, length: {minimum: 8, maximum: 120}, on: :create
  validates :password, length: {minimum: 8, maximum: 120}, on: :update, allow_blank: true

  mount_uploader :photo, UserUploader

  def fullname
    if self.entrepreneur?
      "#{self.entrepreneur.first_name} #{self.entrepreneur.last_name}" rescue self.username
    elsif self.startup?
      "#{self.startup.name}" rescue self.username
    elsif self.investor?
      "#{self.investor.name}" rescue self.username
    end
  end

  def location
    locations = []
    locations << self.country if self.country
    locations << self.region if self.region
    locations << self.city if self.city
    locations.join(', ')
  end

  def avatar
    return 'Profile-Picture-Change-icon.png' if self.photo.blank?
    self.photo
  end

  def like?(idea_id)
    return self.likes.exists?(idea_id: idea_id)
  end

end
