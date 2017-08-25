class RandomizeContractDigest < ActiveRecord::Migration[5.1]
  def change
    User.all.each do |user|
      user.contract_digest = SecureRandom.hex
      user.save
    end
  end
end