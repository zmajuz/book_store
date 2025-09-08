class RemoveCoverImageUrlFromBooks < ActiveRecord::Migration[8.0]
  def change
    remove_column :books, :cover_image_url, :string
  end
end
