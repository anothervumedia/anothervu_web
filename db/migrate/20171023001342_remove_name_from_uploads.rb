class RemoveNameFromUploads < ActiveRecord::Migration[5.1]
  def change
    remove_column :uploads, :name
  end
end
