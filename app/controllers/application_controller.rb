class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :load_institution
  # TODO Abstract this so we don't have to do it on every key.
  before_filter -> { flash.now[:warning] = flash[:warning].html_safe if flash[:html_safe] && flash[:warning] }

  include SessionsHelper
  include FlashHelper
  include ErrorHelper
  # include SubdomainHelper

  def load_institution
    # There's just enough nested logic here to suggest a different
    # approach. There are a lot of `or`s nested within methods,
    # along with a weird memoizing guard clause.

    #  @institution ||= Institution.find_by(subdomain: subdomain)
    return @institution if @institution
    @institution = Institution.find_by(subdomain: subdomain) || default_institution
  end

  def subdomain
    request.subdomain.split('.').first
  end

  def default_institution
    Institution.find_by(id: 1) || Institution.null
  end

  rescue_from CanCan::AccessDenied do |exception|
    store_location
    flash[:danger] = exception.message
    redirect_to main_app.root_path
  end
end
