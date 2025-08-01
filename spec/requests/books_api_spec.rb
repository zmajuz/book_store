require 'rails_helper'

describe 'Books Api', type: :request do
  context 'GET /api/v1/books' do
    context 'when the request is successful' do
      it 'and return all books' do
        book = Book.create(title: 'A culpa é das Estrelas', author_name: 'John Green', cover_image_url: 'http:blablabla.com', price: 25.00)
        book02 = Book.create(title: '1984', author_name: 'George Orwell', cover_image_url: 'http:maismais.com', price: 10.00)

        get '/api/v1/books'
        parsed_json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:ok)
        expect(parsed_json.first[:title]).to eq('A culpa é das Estrelas')
        expect(parsed_json.first[:author_name]).to eq('John Green')
        expect(parsed_json.first[:cover_image_url]).to eq('http:blablabla.com')
        expect(parsed_json.first[:price]).to eq('25.0')
        
        expect(parsed_json.last[:title]).to eq('1984')
        expect(parsed_json.last[:author_name]).to eq('George Orwell')
        expect(parsed_json.last[:cover_image_url]).to eq('http:maismais.com')
        expect(parsed_json.last[:price]).to eq('10.0')
      end

      it 'and return empty list' do
      end
    end
  end
end