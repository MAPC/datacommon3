class Institution < ActiveRecord::Base

  has_one  :branding
  has_many :pages

  has_many :static_maps
  has_many :visualizations

  def camel_name
    short_name.gsub(' ','') # Remove spaces
  end

  def to_s
    camel_name
  end
  
end