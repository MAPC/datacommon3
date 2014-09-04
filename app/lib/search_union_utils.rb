module SearchUnionUtils
  def sql_in(args)
    table, class_name, field_to_search = args

    """
    SELECT
      #{table}.id AS searchable_id,
      '#{class_name}' AS searchable_type,
      #{table}.#{field_to_search} AS term
    FROM #{table}

    UNION
    """
  end

  def index_it(args)
    table, class_name, field_to_search = args

    "CREATE index index_#{table}_on_#{field_to_search} ON #{table} USING gin(to_tsvector('english',#{field_to_search}))"
  end



  sets = [%W(weave_visualization Visualization title),
  %W(weave_visualization Visualization abstract),
  %W(layers Layer title),
  %W(layers Layer alt_title),
  %W(layers Layer descriptn),
  %W(mbdc_calendar StaticMap title),
  %W(mbdc_calendar StaticMap abstract)]

  select_blocks = sets.map { |elem| fill_in(elem) } 
  select_blocks.each { |blk| puts blk }


  indices = sets.map { |elem| index_it(elem) }
  indices.each { |index| puts index }
end