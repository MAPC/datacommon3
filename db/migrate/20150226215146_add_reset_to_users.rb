class AddResetToUsers < ActiveRecord::Migration
  def change
    add_column :auth_user, :reset_digest,  :string
    add_column :auth_user, :reset_sent_at, :datetime
  end
end
