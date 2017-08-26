class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :isEntity, :boolean
    add_column :users, :citizenship, :string
    add_column :users, :socialSecurity, :string
    add_column :users, :organizationType, :string
    User.reset_column_information
    User.update_all(isEntity: true, citizenship: "USA", socialSecurity: "N/A", organizationType: "N/A")
  end
end
