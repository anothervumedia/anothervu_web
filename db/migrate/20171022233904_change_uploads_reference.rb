class ChangeUploadsReference < ActiveRecord::Migration[5.1]
  def change
    add_reference :uploads, :project, foreign_key: true
    remove_reference :uploads, :user, foreign_key: :true
  end
end
