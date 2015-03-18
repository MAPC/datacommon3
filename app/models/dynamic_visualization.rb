require 'nokogiri'

class DynamicVisualization < ActiveRecord::Base
  self.table_name = 'snapshots_visualization'

  before_save :set_legacy_sessionstate

  has_and_belongs_to_many    :data_sources,
    join_table:              :snapshots_visualization_source,
    foreign_key:             :visualization_id,
    association_foreign_key: :datasource_id

  has_and_belongs_to_many    :issue_areas,
    foreign_key:             :visualization_id,
    join_table:              :snapshots_visualization_topics,
    association_foreign_key: :topic_id

  validates :title,       presence: true, length: { minimum: 9 }
  validates :year,        presence: true, length: { minimum: 4 }
  validates :session_state_file_name, presence: true
  validates :overviewmap, inclusion: { in: [true, false] }

  has_attached_file :session_state, path: "/:class/:attachment/:filename"
  validates_attachment_content_type :session_state, content_type: /\A.*\/xml\Z/

  alias_attribute :sources, :data_sources

  def preview(geo, method=:slug)
    @preview ||= OpenStruct.new(
      path: preview_the(:path, geo, method=:slug),
      url:  preview_the(:url,  geo, method=:slug)
    )
  end

  # Render session state for an `object` that has
  # fields `unitid`, `name`, and `subunit_ids`.
  # Make this Rubyish. It should be ERB.
  # http://stackoverflow.com/questions/8954706/render-an-erb-template-with-values-from-a-hash#8955121
  # http://www.kuwata-lab.com/erubis/users-guide.02.html#tut-basic
  # http://www.kuwata-lab.com/erubis/users-guide.02.html#tut-context
  def rendered_state(object)
    "<xml>RENDERED STATE</xml>".html_safe
    # Ideally, with private method erb wrapping Erubis
    # erb( session_state, object )
  end

  alias_method :state, :rendered_state

  def sessionstate
    "/snapshots/visualizations/#{session_state_file_name}"
  end

  def to_s
    title
  end

  def years
    year.split(',')
  end


  private

    # object: geography (municipality or subregion object)
    # method: method to send it in order to get the right file path
    def preview_the(symbol, object, method=:slug)
      string = Rails.configuration.paperclip_defaults[symbol].dup

      replacements = [
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

    def set_legacy_sessionstate
      self.sessionstate = sessionstate
    end


end
