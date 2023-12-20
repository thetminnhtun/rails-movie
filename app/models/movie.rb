class Movie < ApplicationRecord
  paginates_per 24

  has_one_attached :poster, dependent: :destroy

  scope :with_filter, ->(search) { where("title like ?", "%#{search}%") if search.present? }
  scope :"with_attached_#{name}", -> { includes("#{name}_attachment": :blob) }

  validates :title, presence: true
  validates :description, presence: true
  validates :release_date, presence: true
  validates :duration_minutes, presence: true
end
