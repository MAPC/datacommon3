class MakeLastLoginNullable < ActiveRecord::Migration
  def change
    change_column_null :auth_user, :last_login, true
  end
end
