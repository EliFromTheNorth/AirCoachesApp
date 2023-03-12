class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :coaching_offers
  has_many :bookings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_pic, presence: true

  has_one_attached :profile_pic

  # validates_attachment :profile_pic, :content_type => { :content_type => /\Aimage\/jpg/ }
end
