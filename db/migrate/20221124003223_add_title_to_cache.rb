class AddTitleToCache < ActiveRecord::Migration[7.0]
  def change
    add_column :caches, :title, :string
  end
end
