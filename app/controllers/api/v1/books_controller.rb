class Api::V1::BooksController < ApplicationController
  def index
    @books = Book.all
    # render json: @books, serializer: BookSerializer, status: :ok
    render json: BookSerializer.new(@books).serializable_hash
  end
end
