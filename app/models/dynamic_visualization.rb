class DynamicVisualization < ActiveRecord::Base
  self.table_name = 'snapshots_visualization'

  has_and_belongs_to_many :issue_areas,
    join_table: :snapshots_visualization_topics,
    association_foreign_key: :topic_id

  # TODO: There's a more concise way to alias the
  #       sessionstate column than the below. It's 
  #       probably in the Metaprogramming book.

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
    if File.exists? "#{basepath}/images/#{object.send(method)}/#{id}.png"
      "/dynamic_visualizations/images/#{object.send(method)}/#{id}.png"
    else
      "http://unsplash.it/400/400?random"
    end
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
    bracketed    = /(\{{2}.*\}{2})/i
    # Capital S is to match only non-whitespace chars
    inside_brackets  = /\{{2}\s*(\S*)\s*\}{2}/i

    captures = sessionstate.match(bracketed).captures
    state    = sessionstate.dup

    captures.each do |expression|      
      full_method     = expression.match(inside_brackets).captures.first
      replacer_method = full_method.partition('.').last.strip
      replacer_method = replacer_method.gsub(/\|.*/, '') # remove Django filters
      state.gsub!( expression, object.send(replacer_method) )
    end

    state
  end


end
