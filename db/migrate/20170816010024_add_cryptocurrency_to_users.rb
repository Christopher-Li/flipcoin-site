class AddCryptocurrencyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ethAdd, :string
    add_column :users, :bitAdd, :string
    add_column :users, :estimatedContribution, :decimal
    add_column :users, :phoneNumber, :string
  end
end
