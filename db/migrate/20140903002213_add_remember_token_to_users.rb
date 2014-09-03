class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :auth_user, :remember_token, :string
    add_index  :auth_user, :remember_token
  end
end
