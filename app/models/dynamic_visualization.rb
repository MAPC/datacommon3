require 'nokogiri'

class DynamicVisualization < ActiveRecord::Base
  self.table_name = 'snapshots_visualization'

  has_and_belongs_to_many    :data_sources,
    join_table:              :snapshots_visualization_source,
    foreign_key:             :visualization_id,
    association_foreign_key: :datasource_id

  has_and_belongs_to_many    :issue_areas,
    foreign_key:             :visualization_id,
    join_table:              :snapshots_visualization_topics,
    association_foreign_key: :topic_id

  has_attached_file :session_state, path: "/:class/:attachment/:filename"
  validates_attachment_content_type :session_state, content_type: /\A.*\/xml\Z/


  def to_s
    title
  end

  def sources
    data_sources.map {|s| s.title}.join(', ')
  end


  def preview_path(object, method=:slug)
    return "/dynamic_visualizations/images/#{object.send(method)}/#{id}.png" if Rails.env == 'development'
    return "http://#{ENV.fetch('S3_BUCKET_NAME')}/dynamic_visualizations/images/#{object.send(method)}/#{id}.png" if Rails.env == 'production'
  end


  def preview_url(object, method=:slug)
    return "/system/dynamic_visualizations/images/#{object.send(method)}/#{id}.png" if Rails.env == 'development'
    return "http://#{ENV.fetch('S3_BUCKET_NAME')}/dynamic_visualizations/images/#{object.send(method)}/#{id}.png" if Rails.env == 'production'
  end


  # Render session state for an `object` that has
  # fields `unitid`, `name`, and `subunit_ids`.
  def rendered_state(object)
    bracketed = /(\{{2}\s*regionalunit.{0,4}unit_?ids?\s*\}{2})/i # was /(\{{2}.*\}{2})/i, then /(\{{2}\s*regionalunit.unitid\s*\}{2})/i
    # Capital S is to match only non-whitespace chars
    inside_brackets  = /\{{2}\s*(\S*)\s*\}{2}/i

    if Rails.env == 'development'
      state = Nokogiri::XML(open("#{Rails.public_path}/system#{session_state.path}")).to_s
    end

    if Rails.env == 'production'
      state = Nokogiri::XML(open(session_state.url)).to_s
    end
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
