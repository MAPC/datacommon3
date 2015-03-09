class AddInstitutionToUsers < ActiveRecord::Migration
  def change
    add_reference :auth_user, :institution, index: true
  end
end
