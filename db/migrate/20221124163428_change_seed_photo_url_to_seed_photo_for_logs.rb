class ChangeSeedPhotoUrlToSeedPhotoForLogs < ActiveRecord::Migration[7.0]
  def change
    rename_column :logs, :seed_photo_url, :seed_photo
  end
end
