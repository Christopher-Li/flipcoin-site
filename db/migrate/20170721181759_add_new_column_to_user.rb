class AddNewColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :firstName, :string
    add_column :users, :lastName, :string
    remove_column :users, :name
  end
end
