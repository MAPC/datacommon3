RSpec.configure do |config|
  config.include Features::SessionHelpers,    type: :feature
  config.include Features::NavigationHelpers, type: :feature
  config.include Features::FormHelpers,       type: :feature
end