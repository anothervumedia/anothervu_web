class CreateHearts < ActiveRecord::Migration[5.1]
  def change
    create_table :hearts do |t|
      t.references :upload, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
