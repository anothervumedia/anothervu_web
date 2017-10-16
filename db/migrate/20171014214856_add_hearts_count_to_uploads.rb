class AddHeartsCountToUploads < ActiveRecord::Migration[5.1]
  def change
    add_column :uploads, :hearts_count, :integer, default: 0
  end
end
