require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/requests'
  config.hook_into :webmock
  config.configure_rspec_metadata! # Auto-name requests based on test name
  
  config.ignore_request do |request|
    request.include? "package_list"
  end

end