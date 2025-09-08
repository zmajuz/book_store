class BookSerializer
  include JSONAPI::Serializer
  #include Rails.application.routes.url_helpers

  attributes :title, :author_name, :price

  attribute :cover_image_url do |object|
    Rails.application.routes.url_helpers.url_for(object.cover_image) if object.cover_image.attached?
  end
end
