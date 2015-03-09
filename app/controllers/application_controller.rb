class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    store_location
    redirect_to main_app.root_path, alert: exception.message
  end

  def load_institution
    subdomain = request.subdomain.split('.').first
    @institution = Institution.find_by(subdomain: subdomain) || Naught.build { |b| b.black_hole }
  end
end
