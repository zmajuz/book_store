require 'rails_helper'

describe BookSerializer, type: :serializer do
  context 'when a book is serialized' do
    it 'returns the correct attributes in JSON format' do
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/capa_a_culpa.jpg'), 'image/jpeg')

      book = create(
        :book,
        title: 'A culpa é das Estrelas',
        author_name: 'John Green',
        cover_image: file,
        price: 25.00
      )

      serialized = described_class.new(book).serializable_hash

      expect(serialized[:data][:attributes][:title]).to eq('A culpa é das Estrelas')
      expect(serialized[:data][:attributes][:author_name]).to eq('John Green')
      expect(serialized[:data][:attributes][:cover_image_url]).to be_present
      expect(serialized[:data][:attributes][:price].to_f).to eq(25.0)
    end
  end
end