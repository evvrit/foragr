class ChangeAndAddColumnsToSpecies < ActiveRecord::Migration[7.0]
  def change
    rename_column :species, :description, :overview
    rename_column :species, :edible?, :edible
    change_column :species, :edible, :string
    rename_column :species, :invasive?, :features
    change_column :species, :features, :string
    rename_column :species, :usage, :sporeprint
    rename_column :species, :season, :habitat
    rename_column :species, :photo_url, :photos
    add_column :species, :gills, :string
    add_column :species, :leaves, :string
    add_column :species, :flowers, :string
    add_column :species, :fruit, :string
  end
end
