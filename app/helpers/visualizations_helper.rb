module VisualizationsHelper

  def list_relation(object, relation, options={})
    relation = relation.to_s
    relation_method = relation.pluralize.to_sym
    related_objects = object.send( relation_method )
    plural_word     = relation.pluralize( related_objects.count ).capitalize
    join_token      = options.fetch(:join_with) { ', ' }

    "#{ plural_word }: #{ related_objects.join( join_token ) }"
  end

end
