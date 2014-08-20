class Institution < ActiveHash::Base
  include ActiveHash::Associations

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
end