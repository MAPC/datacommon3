class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def load_institution
    @institution = Institution.find_by_subdomain(request.subdomain) || Institution.find(1)
  end
end
