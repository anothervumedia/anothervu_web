class AddCreatorToProject < ActiveRecord::Migration[5.1]
  def change
      add_column :projects, :designer, :string
  end
end
