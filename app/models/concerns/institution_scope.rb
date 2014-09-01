module InstitutionScope
  extend ActiveSupport::Concern

  module ClassMethods

    def institution(institution)
      self.unscoped.order("CASE WHEN institution_id = #{institution.id} THEN 0 ELSE 1 END").default_scope
    end

    def only_inst(institution)
      self.unscoped.where(institution_id: institution.id).default_scope
    end
    
  end

end