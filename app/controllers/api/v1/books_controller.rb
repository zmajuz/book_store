class Api::V1::BooksController < ApplicationController
  def index
    @books = Book.all
    render json: BookSerializer.new(@books).serializable_hash
  end
end
