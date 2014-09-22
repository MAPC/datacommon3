class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def load_institution
    subdomain = request.subdomain.split('.').first
    @institution = Institution.find_by(subdomain: subdomain) || Institution.find(2)
  end
end
