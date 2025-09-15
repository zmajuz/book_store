FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author_name { Faker::Book.author }
    price { Faker::Commerce.price(range: 10.0..100.0) }
    synopsis { Faker::Lorem.paragraph }

    after(:build) do |book|
      image_path = Dir.glob(Rails.root.join('spec/fixtures/files/*')).sample
      if image_path && File.exist?(image_path)
        book.cover_image.attach(
          Rack::Test::UploadedFile.new(
            image_path, 'image/jpeg'
          )
        )
      end
    end
  end
end
