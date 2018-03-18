class UpdateForeignKeyAddOnDeleteConstraint < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :projects, :users
    add_foreign_key :projects, :users, on_delete: :cascade
  end
end
