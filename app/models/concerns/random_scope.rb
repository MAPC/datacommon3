module RandomScope
  extend ActiveSupport::Concern

  module ClassMethods

    def random
      self.offset(rand(self.count(:all))).first
    end
    
  end

end