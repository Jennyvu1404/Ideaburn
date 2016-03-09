class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :startup, dependent: :destroy
  accepts_nested_attributes_for :startup, reject_if: proc { |attributes| attributes['name'].blank? },
    allow_destroy: true

  has_one :investor, dependent: :destroy
  accepts_nested_attributes_for :investor, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true

  has_one :entrepreneur, dependent: :destroy
  accepts_nested_attributes_for :entrepreneur, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true

  validates :username, presence: true, length: { minimum: 5 }
  validates :password, length: { minimum: 8 }
  validates :user_type, presence: true
end
