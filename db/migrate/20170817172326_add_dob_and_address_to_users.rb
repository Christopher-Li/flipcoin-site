class AddDobAndAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :state, :string
    add_column :users, :zipCode, :string
    add_column :users, :city, :string
    add_column :users, :dob, :date
  end
end
