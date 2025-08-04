FactoryBot.define do
  factory :book do
    title { "Até o verão terminar" }
    author_name { "Colleen Hoover" }
    cover_image_url { "https://ate-o-verao-terminar.com.br" }
    price { 49.99 }
  end
end
