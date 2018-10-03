class SorceryBruteForceProtection < ActiveRecord::Migration[5.2]
  def change
    add_column :morpho_users, :failed_logins_count, :integer, :default => 0
    add_column :morpho_users, :lock_expires_at, :datetime, :default => nil
    add_column :morpho_users, :unlock_token, :string, :default => nil

    add_index :morpho_users, :unlock_token
  end
end
