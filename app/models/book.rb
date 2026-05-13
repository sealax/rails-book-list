class Book < ApplicationRecord
  has_many :bookmarks, dependent: :restrict_with_error

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
end
