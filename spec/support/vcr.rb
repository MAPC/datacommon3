require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/requests'
  config.hook_into :webmock
  config.configure_rspec_metadata! # Auto-name requests based on test name
  config.default_cassette_options = { 
    record: :new_episodes,
    re_record_interval: 1.week
  }
end

# Good VCR reference -- may want to use more of the items in here.
# http://tech.xogroupinc.com/post/88009141839/speeding-up-rspec-integration-testing-with-the-vcr