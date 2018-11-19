# frozen_string_literal: true

class SorceryUserActivation < ActiveRecord::Migration[5.2]
  def change
    add_column :morpho_users, :activation_state, :string, :default => nil
    add_column :morpho_users, :activation_token, :string, :default => nil
    add_column :morpho_users, :activation_token_expires_at, :datetime, :default => nil

    add_index :morpho_users, :activation_token
  end
end
