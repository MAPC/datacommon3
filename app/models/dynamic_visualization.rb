class DynamicVisualization < ActiveRecord::Base
  self.table_name = 'snapshots_visualization'

  has_and_belongs_to_many :data_sources,
    join_table: :snapshots_visualization_source,
    foreign_key: :visualization_id,
    association_foreign_key: :datasource_id

  has_and_belongs_to_many :issue_areas,
    foreign_key: :visualization_id,
    join_table: :snapshots_visualization_topics,
    association_foreign_key: :topic_id

  has_attached_file :session_state, path: "/:class/:attachment/:filename"
  validates_attachment_content_type :session_state, content_type: /\A.*\/xml\Z/


  def to_s
    title
  end

  def sources
    data_sources.map {|s| s.title}.join(', ')
  end

  def basepath
    "#{Rails.public_path}/dynamic_visualizations"
  end


  def filename
    filename = read_attribute(:sessionstate).rpartition('/').last
    filename.split('.').first
  end


  def base_image_path
    "#{basepath}/images/#{filename}.png"
  end


  def image_path(object, method=:slug)
    if has_preview?(object, method)
      # TODO return object.to_s instead of sending methods if it's already
      #      a string or an integer
      "/dynamic_visualizations/images/#{object.send(method)}/#{id}.png"
    end
  end


  def preview_path(object, method=:slug)
    "#{basepath}/images/#{object.send(method)}/#{id}.png"
  end


  def has_preview?(object, method=:slug)
    File.exists? preview_path(object, method)
  end


  def has_no_preview?(object, method=:slug)
    !has_preview?(object, method)
  end

  
  def sessionstate_path
    read_attribute(:sessionstate)
  end
  

  def sessionstate
    file_path = "#{basepath}/sessionstates/#{filename}.xml"
    File.open(File.expand_path(file_path), 'rb') { |file| file.read }
  end


  # Render session state for an `object` that has
  # fields `unitid`, `name`, and `subunit_ids`.
  def rendered_state(object)
    bracketed = /(\{{2}\s*regionalunit.{0,4}unit_?ids?\s*\}{2})/i # was /(\{{2}.*\}{2})/i, then /(\{{2}\s*regionalunit.unitid\s*\}{2})/i
    # Capital S is to match only non-whitespace chars
    inside_brackets  = /\{{2}\s*(\S*)\s*\}{2}/i

    state    = sessionstate.dup
    captures = state.match(bracketed).captures

    captures.each do |expression|
      full_method     = expression.match(inside_brackets).captures.first # 'regionalunit.unitd'
      replacer_method = full_method.partition('.').last.strip            # 'unitid'
      replacer_method = replacer_method.gsub(/\|.*/, '')                 # remove Django filters
      state.gsub!( expression, object.send(replacer_method) )            # @municipality.send('unitid')
      puts "#{expression} => #{replacer_method}"
    end

    state.gsub!( /,352/, ',402' )
    state
  end


end
