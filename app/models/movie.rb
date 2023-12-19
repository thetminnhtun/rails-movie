class Movie < ApplicationRecord
  paginates_per 24

  has_one_attached :poster

  scope :with_filter, ->(search) { where("title like ?", "%#{search}%") if search.present? }

  validates :title, presence: true
  validates :description, presence: true
  validates :release_date, presence: true
  validates :duration_minutes, presence: true
end
