class Institution < ActiveRecord::Base

  has_one  :branding

  has_many :heros
  # has_many :layers
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

  rails_admin do
    list do
      # scopes [nil]
      field :short_name do
        column_width 150
      end
      field :subdomain do
        label "domain"
        column_width 200
        formatted_value { "#{bindings[:object].subdomain}.datacommon.org" }
      end
      field :id do
        label "ID"
        column_width 75
      end
      field :visualizations do
        label "Visuals"
        formatted_value { bindings[:object].visualizations.count }
        column_width 75
      end
      field :maps do
        formatted_value { bindings[:object].static_maps.count }
        column_width 75
      end
      field :municipalities do
        label "Munis"
        formatted_value { bindings[:object].municipalities.count }
        column_width 75
      end
      field :subregions do
        formatted_value { bindings[:object].subregions.count }
        column_width 75
      end
    end
    edit do
      field :short_name
      field :long_name
      field :subdomain
      field :region_id
      # field :retina_dimensions
      field :logo, :paperclip
    end
  end

  
end