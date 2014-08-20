class InstitutionsController < ApplicationController
  
  def show
    @institution = Institution.find_by_subdomain(request.subdomain) || Institution.find(1)
  end
end
