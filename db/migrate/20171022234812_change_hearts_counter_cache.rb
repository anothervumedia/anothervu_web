class ChangeHeartsCounterCache < ActiveRecord::Migration[5.1]
  def change
    remove_column :uploads, :hearts_count
    add_column :projects, :hearts_count, :integer, default: 0
  end
end
