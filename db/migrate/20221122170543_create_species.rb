class CreateSpecies < ActiveRecord::Migration[7.0]
  def change
    create_table :species do |t|
      t.string :name
      t.string :description
      t.boolean :invasive?
      t.boolean :edible?
      t.string :usage
      t.string :photo_url
      t.string :season

      t.timestamps
    end
  end
end
