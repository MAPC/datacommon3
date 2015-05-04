require 'capybara'

# Set the following environment variables:
#     CKAN_BASE_URL           - URL to CKAN instance, without http(s)://, i.e. ckan.mydomain.org
#     CKAN_UPLOAD_USERNAME    - username to log into CKAN with
#     CKAN_UPLOAD_PASSWORD    - password to log into CKAN with
#     CKAN_RESOURCE_HOST      - database to layers being connected
#     CKAN_DATAPROXY_USERNAME - user to database where layers are stored
#     CKAN_DATAPROXY_PASSWORD - password to database where layers are stored

module CKANUpload
  DEFAULT_BASE_URL = "http://#{ ENV.fetch('CKAN_BASE_URL') }"

  class Activator
    include Capybara::DSL
    Capybara.current_driver = :webkit

    attr_accessor :base_url

    def initialize(base_url)
      @base_url = base_url || DEFAULT_BASE_URL
    end

    def perform
      "Starting..."
      visit CKANUpload::DEFAULT_BASE_URL
      login = CKANUpload::Login.new.perform
      "Logged in as #{ENV['CKAN_UPLOAD_USERNAME']}."
      Layer.find_each do |layer|
        "Starting layer #{layer.title}..."
        dataset = CKANUpload::DatasetUpload.new(layer)
        dataset.perform unless dataset.exist?
      end
    end

  end
end