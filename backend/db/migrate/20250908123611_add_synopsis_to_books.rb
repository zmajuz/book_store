class AddSynopsisToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :synopsis, :text
  end
end
