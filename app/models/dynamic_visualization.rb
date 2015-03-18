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

  def to_s
    title
  end

  def years
    year.split(',')
  end

  alias_attribute :sources, :data_sources


  def preview(geo, method=:slug)
    @preview ||= OpenStruct.new(
      path: preview_the(:path, geo, method=:slug),
      url:  preview_the(:url,  geo, method=:slug)
    )
  end
  # TODO: Refactor preview into its own object or at least struct

  # Render session state for an `object` that has
  # fields `unitid`, `name`, and `subunit_ids`.
  def rendered_state(object)
    "RENDERED STATE"
    # bracketed = /(\{{2}\s*regionalunit.{0,4}unit_?ids?\s*\}{2})/i # was /(\{{2}.*\}{2})/i, then /(\{{2}\s*regionalunit.unitid\s*\}{2})/i
    # # Capital S is to match only non-whitespace chars
    # inside_brackets  = /\{{2}\s*(\S*)\s*\}{2}/i

    # if Rails.env == 'development'
    #   state = Nokogiri::XML(open("#{Rails.public_path}/system#{session_state.path}")).to_s
    # end

    # if Rails.env == 'production'
    #   state = Nokogiri::XML(open(session_state.url)).to_s
    # end
    # captures = state.match(bracketed).captures

    # captures.each do |expression|
    #   full_method     = expression.match(inside_brackets).captures.first # 'regionalunit.unitd'
    #   replacer_method = full_method.partition('.').last.strip            # 'unitid'
    #   replacer_method = replacer_method.gsub(/\|.*/, '')                 # remove Django filters
    #   state.gsub!( expression, object.send(replacer_method) )            # @municipality.send('unitid')
    #   puts "#{expression} => #{replacer_method}"
    # end

    # state.gsub!( /,352/, ',402' )
    # state
  end

  def sessionstate
    "/snapshots/visualizations/#{session_state_file_name}"
  end

  private

    def set_legacy_sessionstate
      self.sessionstate = sessionstate
    end

    # object: geography (municipality or subregion object)
    # method: method to send it in order to get the right file path
    def preview_the(symbol, object, method=:slug)
      string = Rails.configuration.paperclip_defaults[symbol].dup

      preview_rules = [
        [/:style/,      object.send(method)                 ],
        [/:class/,      self.class.name.underscore.pluralize],
        [/:attachment/, 'images'                            ],
        [/:filename/,   ':basename.:extension'              ],
        [/:basename/,   self.id.to_s                        ],
        [/:extension/,  'png'                               ]
      ]

      preview_rules.each { |e| string.gsub!(e.first, e.last) }
      string
    end


end
