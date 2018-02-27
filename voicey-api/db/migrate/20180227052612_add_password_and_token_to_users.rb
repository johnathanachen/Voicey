class AddPasswordAndTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :toke, :string
    add_index :users, :toke
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
  end
end
