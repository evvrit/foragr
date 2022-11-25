class AddTitleToLog < ActiveRecord::Migration[7.0]
  def change
    add_column :logs, :title, :string
  end
end
