class RemoveFaultyData < ActiveRecord::Migration[5.1]
  def change
    User.update_all(isEntity: nil, citizenship: nil, socialSecurity: nil, organizationType: nil)
  end
end
