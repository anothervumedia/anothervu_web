class AddEmailOptionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email_show, :boolean, default: false
  end
end
