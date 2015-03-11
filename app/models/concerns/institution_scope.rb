module InstitutionScope
  extend ActiveSupport::Concern

  module ClassMethods

    def institution(institution=nil)
      institution_id = id_or_object_for(institution)
      self.unscoped.order("CASE WHEN institution_id = #{institution_id} THEN 0 ELSE 1 END")#.try(:default_scope)
    end

    # TOD: This should just be institution.collaborators
    # def only_inst(institution)
    #   self.unscoped.where(institution_id: institution.id).default_scope
    # end


    private

      def id_or_object_for(institution_or_id)
        return null_institution.id if institution_or_id.nil?
        institution_or_id.try(:id) || institution_or_id
      end

      def null_institution
        @null_institution ||= build_null_institution
      end

      def build_null_institution
        Naught.build { |b|
          b.black_hole
          b.mimic Institution
          def id ; "NULL" ; end
        }.new
      end
    
  end

end