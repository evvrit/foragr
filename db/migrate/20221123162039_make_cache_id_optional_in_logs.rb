class MakeCacheIdOptionalInLogs < ActiveRecord::Migration[7.0]
  def change
    change_column :logs, :cache_id, :bigint, null: true
  end
end
