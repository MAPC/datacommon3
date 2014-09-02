class Profile < ActiveRecord::Base
  if Rails.env == "production"
    self.establish_connection :datacommon
    self.table_name = 'maps_contact'
  end

  self.table_name = 'users'

  belongs_to :user

end
