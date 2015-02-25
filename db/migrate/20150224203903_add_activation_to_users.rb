class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :auth_user, :activation_digest, :string
    add_column :auth_user, :activated_at, :datetime
  end
end
