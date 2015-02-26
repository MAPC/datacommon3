class ChangePasswordToPasswordDigest < ActiveRecord::Migration
  def change
    rename_column :auth_user, :password, :password_digest
  end
end
