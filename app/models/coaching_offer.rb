class CoachingOffer < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_title_description_skill,
  against: [ :title, :description, :skill ],
  using: {
    tsearch: { prefix: true }
  }

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  validates :title, length: { minimum: 5, maximum: 30 }
  validates :description, length: { minimum: 20, maximum: 400 }
  validates :price, presence: true
  validates :user, presence: true
  validates :skill, inclusion: { in: ["Ruby", "Rails", "JavaScript", "HTML", "CSS", "FrontEnd", "BackEnd", "Python", "PHP"] }

  def average_rating
    reviews.average(:rating) || 0
  end

  # def offer_reviews
  #    bookings.extract_associated(:reviews)
  # end
end
