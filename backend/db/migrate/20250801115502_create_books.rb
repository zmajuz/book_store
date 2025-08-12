class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author_name
      t.string :cover_image_url
      t.decimal :price

      t.timestamps
    end
  end
end
