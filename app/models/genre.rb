class Genre < ApplicationRecord
  paginates_per 10

  has_and_belongs_to_many :movies

  validates_presence_of :name
  validates_uniqueness_of :name, allow_blank: true, case_sensitive: false

  scope :with_filter, ->(search) { where("name like ?", "%#{search}%") if search.present? }
end
