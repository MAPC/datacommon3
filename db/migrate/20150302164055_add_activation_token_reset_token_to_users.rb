class AddActivationTokenResetTokenToUsers < ActiveRecord::Migration
  def change
    add_column :auth_user, :activation_token, :string
    add_column :auth_user, :reset_token,      :string
  end
end
