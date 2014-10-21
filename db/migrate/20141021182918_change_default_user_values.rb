class ChangeDefaultUserValues < ActiveRecord::Migration
  def change
    change_column_default :auth_user, :is_active,    true
    change_column_default :auth_user, :is_staff,     false
    change_column_default :auth_user, :is_superuser, false
    change_column_default :auth_user, :date_joined,  Time.now
    change_column_default :auth_user, :last_login,   Time.now
  end
end
