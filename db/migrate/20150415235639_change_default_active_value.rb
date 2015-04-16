class ChangeDefaultActiveValue < ActiveRecord::Migration
  def up
    change_column_default :auth_user, :is_active, false
  end

  def down
    change_column_default :auth_user, :is_active, true
  end
end
