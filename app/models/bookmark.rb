class Bookmark < ApplicationRecord
  belongs_to :book
  belongs_to :list

  validates :comment, length: { minimum: 6, maximum: 300 }, allow_blank: false
  validates :book, uniqueness: { scope: :list, message: "is already in this list" }
end
