class Profile < ActiveRecord::Base
  self.table_name = 'maps_contact' # formerly 'users'
  self.primary_key = :id

  belongs_to :user

  def name
    read_attribute(:name).titleize
  end

  def fname
    user.fname
  end

  def country_name
    ISO3166::Country[country]
  end

end
