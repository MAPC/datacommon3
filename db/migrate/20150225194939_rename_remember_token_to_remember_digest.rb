class RenameRememberTokenToRememberDigest < ActiveRecord::Migration
  def change
    rename_column :auth_user, :remember_token, :remember_digest
  end
end
