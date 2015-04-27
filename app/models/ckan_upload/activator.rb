require 'capybara'

module CKANUpload
  DEFAULT_BASE_URL = 'http://ckan.dev.mapc.org'

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