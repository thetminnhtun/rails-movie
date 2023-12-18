class Movie < ApplicationRecord
  paginates_per 24

  has_one_attached :poster

  scope :with_filter, ->(search) { where("title like ?", "%#{search}%") if search.present? }
end
