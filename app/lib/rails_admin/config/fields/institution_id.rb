class InstitutionId < RailsAdmin::Config::Fields::Base
  def self.inherited(klass)
    super(klass)
  end

  register_instance_option :formatted_value do
    b = bindings[:object]
    Institution.find_by(id: b.institution_id).try(:short_name)
  end
end
