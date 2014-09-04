=begin

The template is as follows:

SELECT
  #{table}.id AS searchable_id,
  '#{class_name}' AS searchable_type,
  #{table}.#{field_to_search} AS term
FROM #{table}

UNION

...

CREATE index index_#{table}_on_#{field_to_search} ON #{table} USING gin(to_tsvector('english',#{field_to_search}))


=end

class CreateSearchesView < ActiveRecord::Migration
  def up
    q = """
      CREATE VIEW searches AS
        SELECT
          weave_visualization.id AS searchable_id,
          'Visualization' AS searchable_type,
          weave_visualization.title AS term
        FROM weave_visualization

        UNION


        SELECT
          weave_visualization.id AS searchable_id,
          'Visualization' AS searchable_type,
          weave_visualization.abstract AS term
        FROM weave_visualization

        UNION


        SELECT
          layers.id AS searchable_id,
          'Layer' AS searchable_type,
          layers.title AS term
        FROM layers

        UNION


        SELECT
          layers.id AS searchable_id,
          'Layer' AS searchable_type,
          layers.alt_title AS term
        FROM layers

        UNION


        SELECT
          layers.id AS searchable_id,
          'Layer' AS searchable_type,
          layers.descriptn AS term
        FROM layers

        UNION


        SELECT
          mbdc_calendar.id AS searchable_id,
          'StaticMap' AS searchable_type,
          mbdc_calendar.title AS term
        FROM mbdc_calendar

        UNION


        SELECT
          mbdc_calendar.id AS searchable_id,
          'StaticMap' AS searchable_type,
          mbdc_calendar.abstract AS term
        FROM mbdc_calendar

    """
    query = q.gsub("\n", '').gsub(/\s{2,}/, ' ')
    execute query

    execute "CREATE INDEX index_weave_visualization_on_title ON weave_visualization USING gin(to_tsvector('english',title))"
    execute "CREATE INDEX index_weave_visualization_on_abstract ON weave_visualization USING gin(to_tsvector('english',abstract))"
    execute "CREATE INDEX index_layers_on_title ON layers USING gin(to_tsvector('english',title))"
    execute "CREATE INDEX index_layers_on_alt_title ON layers USING gin(to_tsvector('english',alt_title))"
    execute "CREATE INDEX index_layers_on_descriptn ON layers USING gin(to_tsvector('english',descriptn))"
    execute "CREATE INDEX index_mbdc_calendar_on_title ON mbdc_calendar USING gin(to_tsvector('english',title))"
    execute "CREATE INDEX index_mbdc_calendar_on_abstract ON mbdc_calendar USING gin(to_tsvector('english',abstract))"
  end

  def down
    execute "DROP VIEW searches"
    execute "DROP INDEX index_weave_visualization_on_title"
    execute "DROP INDEX index_weave_visualization_on_abstract"
    execute "DROP INDEX index_layers_on_title"
    execute "DROP INDEX index_layers_on_alt_title"
    execute "DROP INDEX index_layers_on_descriptn"
    execute "DROP INDEX index_mbdc_calendar_on_title"
    execute "DROP INDEX index_mbdc_calendar_on_abstract"
  end
end
