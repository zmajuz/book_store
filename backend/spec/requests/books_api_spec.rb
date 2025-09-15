require 'rails_helper'

describe 'Books Api', type: :request do
  context 'GET /api/v1/books' do
    context 'when the request is successful' do
      it 'and return all books' do
        file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/capa_a_culpa.jpg'), 'image/jpeg')

        book = create(
          :book,
          title: 'A culpa é das Estrelas',
          author_name: 'John Green',
          cover_image: file,
          price: 25.00
        )
        book02 = create(
          :book,
          title: '1984',
          author_name: 'George Orwell',
          cover_image: file,
          price: 10.00
        )

        get '/api/v1/books'

        expect(response).to have_http_status(:ok)
        expect(response_data.first[:attributes][:title]).to eq('A culpa é das Estrelas')
        expect(response_data.first[:attributes][:author_name]).to eq('John Green')
        expect(response_data.first[:attributes][:cover_image_url]).to be_present
        expect(response_data.first[:attributes][:price]).to eq('25.0')

        expect(response_data.last[:attributes][:title]).to eq('1984')
        expect(response_data.last[:attributes][:author_name]).to eq('George Orwell')
        expect(response_data.last[:attributes][:cover_image_url]).to be_present
        expect(response_data.last[:attributes][:price]).to eq('10.0')
      end

      it 'and return empty list' do
        get '/api/v1/books'

        expect(response).to have_http_status(:ok)
        expect(response_data).to be_empty
      end
    end
  end

  context 'GET /api/v1/books/:id' do
    context 'when the request is successful' do
      it 'and return a book'do
        file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/capa_a_culpa.jpg'), 'image/jpeg')

        book = create(
          :book,
          title: 'A culpa é das Estrelas',
          author_name: 'John Green',
          cover_image: file,
          price: 25.00,
          synopsis: "Hazel Grace Lancaster e Augustus Waters são dois adolescentes que se conhecem em um grupo de apoio " \
          "para pacientes com câncer. Por causa da doença, Hazel sempre descartou a ideia de se envolver amorosamente, " \
          "mas acaba cedendo ao se apaixonar por Augustus. Juntos, eles viajam para Amsterdã, onde embarcam em uma jornada " \
          "inesquecível."
        )
        book02 = create(
          :book,
          title: '1984',
          author_name: 'George Orwell',
          cover_image: file,
          price: 10.00,
          synopsis: "Romance distópico que retrata a vida na Oceania, uma sociedade totalitária controlada pelo Partido " \
          "e seu líder onipresente, o Grande Irmão."
        )

        get "/api/v1/books/#{book.id}"

        expect(response).to have_http_status(:ok)
        expect(response_data[:attributes][:title]).to eq('A culpa é das Estrelas')
        expect(response_data[:attributes][:author_name]).to eq('John Green')
        expect(response_data[:attributes][:cover_image_url]).to be_present
        expect(response_data[:attributes][:price]).to eq('25.0')
        expect(response_data[:attributes][:synopsis]).to be_present

        expect(response_data[:attributes][:title]).to_not eq('1984')
        expect(response_data[:attributes][:author_name]).to_not eq('George Orwell')
        expect(response_data[:attributes][:price]).to_not eq('10.0')
      end

      context 'when the book does not exist' do
        it 'and return a 404' do
          get '/api/v1/books/999'

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
