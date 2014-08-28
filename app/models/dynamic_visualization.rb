class DynamicVisualization < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = 'snapshots_visualization'

  has_and_belongs_to_many :issue_areas,
    join_table: :snapshots_visualization_topics,
    association_foreign_key: :topic_id

  # TODO: There's a more concise way to alias the
  #       sessionstate column than the below. It's 
  #       probably in the Metaprogramming book.

  def sessionstate
    vis_path  = read_attribute(:sessionstate).partition('/').last
    file_path = "#{Rails.root}/public/dynamic_#{vis_path}"
    File.open(File.expand_path file_path).read
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
      state.gsub!( expression, object.send(replacer_method) )
    end

    state
  end

  def sessionstate_path
    read_attribute(:sessionstate)
  end

end
