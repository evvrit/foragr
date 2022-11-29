class CreateCacheSpecies < ActiveRecord::Migration[7.0]
  def change
    create_table :cache_species do |t|
      t.references :cache, null: false, foreign_key: true
      t.references :species, null: false, foreign_key: true

      t.timestamps
    end
  end
end
