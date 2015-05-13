# Avoid Travis error claiming these modules are not loaded.
Dir[Rails.root.join("spec/support/features/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Features::SessionHelpers,    type: :feature
  config.include Features::NavigationHelpers, type: :feature
  config.include Features::FormHelpers,       type: :feature
end