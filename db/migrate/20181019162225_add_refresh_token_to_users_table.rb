# frozen_string_literal: true

class AddRefreshTokenToUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :morpho_users, :refresh_token, :string, index: true
  end
end
