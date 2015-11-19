class Profile < ActiveRecord::Base
  self.table_name = 'maps_contact' # formerly 'users'
  self.primary_key = :id

  belongs_to :user

  before_save :ensure_http

  def name
    read_attribute(:name).to_s.titleize
  end

  def fname
    user.fname.to_s
  end

  def country_name
    ISO3166::Country[country].to_s
  end

  private

    def ensure_http
      unless website_url =~ /^https?:\/\//
        assign_attributes website_url: "http://#{website_url}"
      end
    end

end
