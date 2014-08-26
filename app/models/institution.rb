class Institution < ActiveHash::Base
  include ActiveHash::Associations

  has_one  :branding
  has_many :pages

  self.data = [
    { 
      id: 1,
      short_name: "Metro Boston",
      long_name:  "Metropolitan Boston",
      subdomain:  "metroboston"
    },
    { 
      id: 2,
      short_name: "Central Mass",
      long_name:  "Central Massachusetts",
      subdomain:  "centralmass"
    }
  ]

  def camel_name
    short_name.gsub(' ','') # Remove spaces
  end

  def to_s
    camel_name
  end
  
end