class BookSerializer
  include JSONAPI::Serializer

  attributes :title, :author_name, :price

  attribute :cover_image_url do |book|
    Rails.application.routes.url_helpers.url_for(book.cover_image) if book.cover_image.attached?
  end
end
