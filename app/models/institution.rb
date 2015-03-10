class Institution < ActiveRecord::Base

  has_one  :branding

  has_many :heros
  has_many :layers
  has_many :pages
  has_many :static_maps
  has_many :visualizations

  has_many :municipalities
  has_many :subregions

  validates :long_name,  presence: true
  validates :short_name, presence: true
  validates :subdomain,  presence: true
  
  # retina!
  has_attached_file :logo, styles: { favicon: ['16x16#',  :png],
                                     header:  ['245x80>', :png] }
                           # retina: { quality: 80 }

  validates :logo_file_name, presence: true
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  
  def camel_name
    short_name.gsub(' ','') # Remove spaces
  end

  def to_s
    camel_name
  end

  def featured_visualization
    visualizations.featured.first # was #sample not #first
  end

  # alias_attribute :muni_id, :region_id
  
end