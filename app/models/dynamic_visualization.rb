class DynamicVisualization < ActiveRecord::Base
  self.table_name = 'snapshots_visualization'
  self.primary_key = :id
  self.inheritance_column = nil # The :type column tried to find a STI subclass

  before_save :set_legacy_sessionstate

  has_and_belongs_to_many    :data_sources,
    join_table:              :snapshots_visualization_source,
    foreign_key:             :visualization_id,
    association_foreign_key: :datasource_id

  has_and_belongs_to_many    :issue_areas,
    foreign_key:             :visualization_id,
    join_table:              :snapshots_visualization_topics,
    association_foreign_key: :topic_id

  include DataResourceFilters

  validates :title,       presence: true, length: { minimum: 9 }
  validates :year,        presence: true, length: { minimum: 4 }
  validates :session_state_file_name, presence: true
  validates :overviewmap, inclusion: { in: [true, false] }
  validates :type, presence: true #, inclusion: { in: Geography.types } # can't effectively test validation

  has_attached_file :session_state
  validates_attachment_content_type :session_state, content_type: /\A.*\/xml\Z/

  alias_attribute :sources, :data_sources
  alias_attribute :unitid,  :unit_id

  def self.default_scope
    order(:title)
  end

  def preview(geo, method=:slug)
    potential_path = preview_the(:path, geo, method=:slug)
    potential_url  = preview_the(:url,  geo, method=:slug)

    path = potential_path.dup
    url  = potential_url.dup

    begin
      file = open(potential_url)
    rescue
      file = nil
    end

    unless file # if file does not exist
      path = path.gsub /[a-z\-]+\/\d+\.png$/i, 'missing.png'
      url  = url.gsub  /[a-z\-]+\/\d+\.png$/i, 'missing.png'
    end

    @preview ||= OpenStruct.new( path: path, url: url, potential_path: potential_path, potential_url: potential_url )
  end

  # Render session state for an object (probably Geography) that has
  # fields :unitid, :name, and :subunit_ids.
  def rendered_state(object)
    render_erb( object )
  end

  alias_method :state, :rendered_state

  # TODO: What is this for, exactly?
  def sessionstate
    "/snapshots/visualizations/#{session_state_file_name}"
  end

  def to_s
    title
  end

  def years
    year.split(',')
  end

  rails_admin do
    list do
      field :title
      field :year do
        formatted_value { bindings[:object].years.join(', ') }
      end
      field :topics do
        formatted_value { bindings[:object].topics.map(&:to_s).join(', ') }
      end
      field :session_state_file_name do
        label "Filename"
      end
      field :session_state_updated_at do
        label "Updated"
        # TODO: column_width 100
      end
    end

    edit do
      field :title
      field :year
      field :session_state, :paperclip
      field :data_sources
      field :issue_areas
    end
  end


  private

    # object: geography (municipality or subregion object)
    # method: method to send it in order to get the right file path
    def preview_the(symbol, object, method=:slug)
      paperclip_defaults = Rails.configuration.paperclip_defaults.dup
      string = paperclip_defaults[symbol].dup

      if paperclip_defaults[:storage] == :s3
        bucket  = paperclip_defaults[:s3_credentials][:bucket]
        s3_host = paperclip_defaults[:s3_host_name]
      end

      replacements = [
        [/:s3_domain_url/, "http://#{bucket}.#{s3_host}#{paperclip_defaults[:path]}" ],
        [/:style/,      object.send(method)                 ],
        [/:class/,      self.class.name.underscore.pluralize],
        [/:attachment/, 'images'                            ],
        [/:filename/,   ':basename.:extension'              ],
        [/:basename/,   self.id.to_s                        ],
        [/:extension/,  'png'                               ]
      ]

      replacements.each { |e| string.gsub!(e.first, e.last) }
      string
    end

    def render_erb(object)
      template = template_for_environment
      Erubis::Eruby.new(template).result(binding()).html_safe
    end

    def template_for_environment
      if Rails.env == 'production' || ENV['S3_ATTACHMENT_STORAGE'].to_b == true
        template = OpenURI.open_uri( self.session_state.url ) {|file| file.read}
      else
        template = File.open(self.session_state.path) {|file| file.read}
      end
    end

    def set_legacy_sessionstate
      self.sessionstate = sessionstate
    end


end
