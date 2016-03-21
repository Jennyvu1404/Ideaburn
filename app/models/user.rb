class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable, :confirmable

  ratyrate_rater

  has_many :ideas
  has_many :comments
  has_many :likes
  has_many :notifications
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
      "#{self.entrepreneur.first_name.capitalize} #{self.entrepreneur.last_name.capitalize}" rescue self.username
    elsif self.startup?
      self.startup.name rescue self.username
    elsif self.investor?
      self.investor.name rescue self.username
    end
  end

  def location
    country = Carmen::Country.coded(self.country) if self.country
    subregions = country.subregions unless country.nil?
    region = subregions.coded(self.region) if self.region && subregions.present?
    locations = []
    locations << country.name if country
    locations << region.name if region
    locations << self.city if self.city
    locations.join(', ')
  end

  def avatar
    return ActionController::Base.helpers.asset_path('Profile-Picture-Change-icon.png') if self.photo.blank?
    self.photo
  end

  def like?(idea_id)
    return self.likes.exists?(idea_id: idea_id)
  end

  def country_name
    country = Carmen::Country.coded(self.country) if self.country
    country.name rescue country
  end

end
