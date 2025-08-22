FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author_name { Faker::Book.author }
    cover_image_url { Faker::Internet.url(host: 'example.com', path: '/cover.jpg') }
    price { Faker::Commerce.price(range: 10.0..100.0) }
  end
end
