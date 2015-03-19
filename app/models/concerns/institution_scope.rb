module InstitutionScope
  extend ActiveSupport::Concern

  module ClassMethods

    # Return all objects, with the given institution's
    # objects first, the rest following.
    # TODO: Would like to implement this using #sort_by{},
    # but haven't gotten the comparison working right yet.
    def institution(institution_or_id=nil, options={})
      institution_id = id_for(institution_or_id)
      default = options.fetch(:default) { true  }
      only    = options.fetch(:only)    { false }

      scope = self.unscoped.order("CASE WHEN institution_id = #{institution_id} THEN 0 ELSE 1 END")
      
      # Limits to a given institution if { only: true }
      if only && !institution_or_id.nil?
        scope = scope.where(institution_id: institution_id)
      end

      # Doesn't try :default_scope if { default: false }
      scope = scope.try(:default_scope) if default
      scope
    end

    private

      # Return the id, regardless of whether given an
      # institution or its id.
      def id_for(institution_or_id)
        return null_institution.id if institution_or_id.nil?
        institution_or_id.try(:id) || institution_or_id
      end

      # Memoize null_institution
      def null_institution
        @null_institution ||= build_null_institution
      end

      # Build the null_institution as a black hole mimic
      # with id=NULL to make the query in the scope work.
      def build_null_institution
        Naught.build { |b|
          b.black_hole
          b.mimic Institution
          def id ; "NULL" ; end
        }.new
      end
    
  end

end