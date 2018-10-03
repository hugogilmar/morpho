class SorceryCore < ActiveRecord::Migration[5.2]
  def change
    create_table :morpho_users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt

      t.timestamps                :null => false
    end

    add_index :morpho_users, :email, unique: true
  end
end
