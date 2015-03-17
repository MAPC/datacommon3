class SnapshotFacade

  def initialize(options={})
    @geography = object_for( options.fetch(:geography), class_name: :geography )
    @topic     = object_for( options.fetch(:topic),     class_name: :topic     )
  end


  # TODO: Handle `nil` case
  def object_for(object_or_id, options={})
    # Return the object immediately if it's not an integer.
    return object_or_id unless object_or_id.is_a? Fixnum
    
    # Find the object for the given class_name.
    class_name = options.fetch(:class_name) { 
      raise ArgumentError, 'Passed object is an ID and no option `class_name` was provided.'
    }
    object = const_get(class_name).find(object_or_id)
    raise StandardError, 'No object found; would have returned nil.' if object.nil?
    return object
  end

end