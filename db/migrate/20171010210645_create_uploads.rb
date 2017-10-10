class CreateUploads < ActiveRecord::Migration[5.1]
  def change
    create_table :uploads do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :image
      t.string :video
    end
  end
end
