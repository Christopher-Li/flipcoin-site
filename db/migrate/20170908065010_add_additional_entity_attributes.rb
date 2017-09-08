class AddAdditionalEntityAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :equityOwners, :string
    add_column :users, :entityType, :string
  end
end
