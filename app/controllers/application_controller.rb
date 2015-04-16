class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  # include SubdomainHelper

  def load_institution
    subdomain = request.subdomain.split('.').first
    logger.debug "SUBDOMAIN: #{subdomain.inspect}"
    @institution = Institution.find_by(subdomain: subdomain) || Institution.first # Institution.null
  end

  rescue_from CanCan::AccessDenied do |exception|
    store_location
    flash[:danger] = exception.message
    redirect_to main_app.root_path
  end
end
