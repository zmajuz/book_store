require 'rails_helper'

describe 'Books Api', type: :request do
  context 'GET /api/v1/books' do
    context 'when the request is successful' do
      it 'and return all books' do
        book = create(
          :book,
          title: 'A culpa é das Estrelas',
          author_name: 'John Green',
          cover_image_url: 'http:blablabla.com',
          price: 25.00
        )
        book02 = create(
          :book,
          title: '1984',
          author_name: 'George Orwell',
          cover_image_url: 'http:maismais.com',
          price: 10.00
        )

        get '/api/v1/books'

        expect(response).to have_http_status(:ok)
        expect(response_data.first[:attributes][:title]).to eq('A culpa é das Estrelas')
        expect(response_data.first[:attributes][:author_name]).to eq('John Green')
        expect(response_data.first[:attributes][:cover_image_url]).to eq('http:blablabla.com')
        expect(response_data.first[:attributes][:price]).to eq('25.0')

        expect(response_data.last[:attributes][:title]).to eq('1984')
        expect(response_data.last[:attributes][:author_name]).to eq('George Orwell')
        expect(response_data.last[:attributes][:cover_image_url]).to eq('http:maismais.com')
        expect(response_data.last[:attributes][:price]).to eq('10.0')
      end

      it 'and return empty list' do
        get '/api/v1/books'

        expect(response).to have_http_status(:ok)
        expect(response_data).to be_empty
      end
    end
  end
end
