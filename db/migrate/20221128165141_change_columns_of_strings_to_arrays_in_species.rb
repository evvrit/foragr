class ChangeColumnsOfStringsToArraysInSpecies < ActiveRecord::Migration[7.0]
  def change
    change_column :species, :overview, :string, array: true, default: [], using: "(string_to_array(overview, ','))"
  end
end
