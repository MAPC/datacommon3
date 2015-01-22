class Profile < ActiveRecord::Base
  self.table_name = 'maps_contact' # formerly 'users'
  
  belongs_to :user

  def name
    read_attribute(:name).titleize
  end

  def fname
    user.fname
  end

end
