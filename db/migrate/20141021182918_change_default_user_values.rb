class ChangeDefaultUserValues < ActiveRecord::Migration
  def change
    change_column_default :auth_user, :is_active,    true
    change_column_default :auth_user, :is_staff,     false
    change_column_default :auth_user, :is_superuser, false
    execute('ALTER TABLE "auth_user" ALTER COLUMN "date_joined" SET DEFAULT CURRENT_DATE')
    execute('ALTER TABLE "auth_user" ALTER COLUMN "last_login" SET DEFAULT CURRENT_DATE')
  end
end
