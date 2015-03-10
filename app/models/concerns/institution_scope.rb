module InstitutionScope
  extend ActiveSupport::Concern

  module ClassMethods

    def institution(institution=nil)
      institution = build_null_institution if institution.nil?
      self.unscoped.order("CASE WHEN institution_id = #{institution.id} THEN 0 ELSE 1 END")#.try(:default_scope)
    end

    # TOD: This should just be institution.collaborators
    # def only_inst(institution)
    #   self.unscoped.where(institution_id: institution.id).default_scope
    # end


    private

      def build_null_institution
        Naught.build { |b|
          b.black_hole
          b.mimic Institution
          def id ; "NULL" ; end
        }.new
      end
    
  end

end