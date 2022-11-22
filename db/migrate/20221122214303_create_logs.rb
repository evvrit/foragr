class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.text :content
      t.date :created_on
      t.string :seed_photo_url
      t.references :user, null: false, foreign_key: true
      t.references :cache, null: false, foreign_key: true

      t.timestamps
    end
  end
end
