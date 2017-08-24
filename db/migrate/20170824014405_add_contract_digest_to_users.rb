class AddContractDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :contract_digest, :string
    User.reset_column_information
    User.update_all(contract_digest: SecureRandom.hex)
  end
end
