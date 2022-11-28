class ChangeMoreColumnsofStringsToArraysInSpecies < ActiveRecord::Migration[7.0]
  def change
    change_column :species, :features, :string, array: true, default: [], using: "(string_to_array(features, ','))"
    change_column :species, :edible, :string, array: true, default: [], using: "(string_to_array(edible, ','))"
    change_column :species, :sporeprint, :string, array: true, default: [], using: "(string_to_array(sporeprint, ','))"
    change_column :species, :photos, :string, array: true, default: [], using: "(string_to_array(photos, ','))"
    change_column :species, :habitat, :string, array: true, default: [], using: "(string_to_array(habitat, ','))"
    change_column :species, :gills, :string, array: true, default: [], using: "(string_to_array(gills, ','))"
    change_column :species, :leaves, :string, array: true, default: [], using: "(string_to_array(leaves, ','))"
    change_column :species, :flowers, :string, array: true, default: [], using: "(string_to_array(flowers, ','))"
    change_column :species, :fruit, :string, array: true, default: [], using: "(string_to_array(fruit, ','))"
  end
end
