require 'rails_helper'

describe BookSerializer, type: :serializer do
  context 'when a book is serialized' do
    let(:book) { create(:book, title: 'A culpa é das Estrelas', author_name: 'John Green', price: 25.00) }

    it 'returns the correct attributes in JSON format' do
      serialized = described_class.new(book).serializable_hash

      expect(serialized[:data][:attributes][:title]).to eq('A culpa é das Estrelas')
      expect(serialized[:data][:attributes][:author_name]).to eq('John Green')
      expect(serialized[:data][:attributes][:cover_image_url]).to be_present
      expect(serialized[:data][:attributes][:price].to_f).to eq(25.0)
    end

    it 'returns the expected keys in attributes' do
      serialized = described_class.new(book).serializable_hash

      expect(serialized[:data][:attributes].keys).to match_array(
        %i[
          title
          author_name
          price
          cover_image_url
        ]
      )
    end
  end
end
