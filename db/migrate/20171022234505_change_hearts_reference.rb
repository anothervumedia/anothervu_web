class ChangeHeartsReference < ActiveRecord::Migration[5.1]
  def change
    add_reference :hearts, :project, foreign_key: true
    remove_reference :hearts, :upload, foreign_key: :true
  end
end
