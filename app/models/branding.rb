class Branding < ActiveHash::Base
  include ActiveHash::Associations

  belongs_to :institution

  self.data = [
    { 
      id: 1,
      institution_id: 1,
      logo_url: 'logos/metro_boston_data_common.png',
      about: "The MetroBoston DataCommon is an interactive data portal and online mapping tool that....",
      tagline: "A partnership between the Metropolitan Area Planning Council and the Boston Indicators Project at the Boston Foundation",
      featured_visualization_id: 1395,
      map_gallery_intro: "Explore MAPC's Annual Report and Calendar maps, illustrating conditions in the region and see whether the map you want may already exist."
    },
    { 
      id: 2,
      institution_id: 2,
      logo_url: 'logos/central_mass_data_common.png',
      about: "The CentralMass DataCommon is an interactive data portal and online mapping tool that....",
      tagline: "A partnership between the Central Massachusetts Regional Planning Commission and the Worcester Indicators Project at the Worcester Foundation",
      featured_visualization_id: 23,
      map_gallery_intro: "Explore CMRPC's maps, illustrating conditions in the region and see whether the map you want may already exist."
    }
  ]
  
end