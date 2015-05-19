class Institution < ActiveRecord::Base
  self.primary_key = "id"

  has_one  :branding
  has_many :heros
  has_many :static_maps
  has_many :visualizations
  has_many :geographies
  has_and_belongs_to_many :logos

  validates :long_name,  presence: true
  validates :short_name, presence: true
  validates :subdomain,  presence: true
  
  has_attached_file :logo, styles: { favicon: ['16x16#',  :png],
                                     header:  ['160x52>', :png],
                                     large:   ['245x80>', :png] }

  validates :logo_file_name, presence: true
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  
  def camel_name
    short_name.gsub(' ','') # Remove spaces
  end

  def to_s
    camel_name
  end

  def domain
    base_host = Rails.configuration.action_mailer.default_url_options[:host]
    "#{ subdomain }.#{ base_host }"
  end

  def featured_visualization
    visualizations.featured.first.presence || Visualization.first
  end

  def self.null
    # Memoize null_institution
    @null_institution ||= build_null_institution
  end

  # alias_attribute :muni_id, :region_id

  rails_admin do
    object_label_method do
      :short_name
    end
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
      field :geographies do
        label "Munis"
        formatted_value { bindings[:object].geographies.count }
        column_width 75
      end
    end
    edit do
      field :short_name
      field :long_name
      field :subdomain
      field :region_id
      field :id do
        read_only true
      end
      field :logo, :paperclip
    end
  end

  private

    # Build the null_institution as a black hole mimic
    # with id=NULL to make the query in the scope work.
    def self.build_null_institution
      Naught.build { |b|
        b.black_hole
        b.mimic Institution
        def id ; "NULL" ; end
        def to_s ; "Null Institution" ; end
        def presence ; nil ; end
      }.new
    end

  
end