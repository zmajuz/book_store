class Book < ApplicationRecord
  validates :title, :author_name, :cover_image_url, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
