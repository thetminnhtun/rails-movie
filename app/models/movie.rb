class Movie < ApplicationRecord
  paginates_per 3

  has_one_attached :poster
end
