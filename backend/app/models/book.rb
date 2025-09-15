class Book < ApplicationRecord
  validates :title, :author_name, :cover_image, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  has_one_attached :cover_image
end
