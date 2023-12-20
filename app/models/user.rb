class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  paginates_per 10
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :name, presence: true, length: { maximum: 255 }

  validates_presence_of :email
  validates_uniqueness_of :email, allow_blank: true, case_sensitive: true
  validates_format_of :email, with: VALID_EMAIL_REGEX, allow_blank: true

  validates_presence_of :password, on: :create
  validates_confirmation_of :password, on: :create

  scope :with_filter, ->(search) {
          where("name like :search or email like :search", search: "%#{search}%") if search.present?
        }
end
