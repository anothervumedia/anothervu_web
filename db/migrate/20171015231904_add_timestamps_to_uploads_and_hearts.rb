class AddTimestampsToUploadsAndHearts < ActiveRecord::Migration[5.1]
  def up
    add_column :uploads, :created_at, :datetime, null: false, default: Time.now
    add_column :uploads, :updated_at, :datetime, null: false, default: Time.now

    add_column :hearts, :created_at, :datetime, null: false, default: Time.now
    add_column :hearts, :updated_at, :datetime, null: false, default: Time.now
  end

  def down
    remove_column :uploads, :created_at
    remove_column :uploads, :updated_at

    remove_column :hearts, :created_at
    remove_column :hearts, :updated_at
  end
end
