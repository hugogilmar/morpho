# frozen_string_literal: true

class SorceryExternal < ActiveRecord::Migration[5.2]
  def change
    create_table :morpho_authentications do |t|
      t.integer :user_id, :null => false
      t.string :provider, :uid, :null => false

      t.timestamps              :null => false
    end

    add_index :morpho_authentications, [:provider, :uid]
  end
end
