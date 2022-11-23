class CreateCaches < ActiveRecord::Migration[7.0]
  def change
    create_table :caches do |t|
      t.float :longitude
      t.float :latitude
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.date :found_on
      t.string :seed_photo

      t.timestamps
    end
  end
end
