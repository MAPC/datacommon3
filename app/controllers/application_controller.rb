class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  # include SubdomainHelper

  def load_institution
    subdomain = request.subdomain.split('.').first
    logger.debug "SUBDOMAIN: #{subdomain.inspect}"
    @institution = Institution.find_by(subdomain: subdomain) || null_institution
  end

  # Memoize the null institution
  def null_institution
    @null_institution ||= Naught.build { |b| 
      b.mimic Institution
      b.black_hole
      def id ; "NULL" ; end
    }
  end

  rescue_from CanCan::AccessDenied do |exception|
    store_location
    redirect_to main_app.root_path, alert: exception.message
  end
end
