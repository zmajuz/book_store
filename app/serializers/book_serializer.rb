class BookSerializer
  include JSONAPI::Serializer
  attributes :title, :author_name, :cover_image_url, :price
end
