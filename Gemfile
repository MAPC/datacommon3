source 'https://rubygems.org'
ruby   '2.1.5'

gem 'rails',                '4.1.5'


# Database
gem 'pg',                   '0.17.1'   # Use PostgreSQL as the database for Active Record
gem 'postgres_ext-postgis'             # PostGIS Column Support
gem 'textacular',           '3.2.0'    # Enables PostgreSQL Fulltext Search
gem 'has_scope',            '0.5.1'    # Handle multiply-scoped models
gem 'lazy_columns',
  github: 'jorgemanrubia/lazy_columns' # Lazy-load large columns

# CKAN Data Store
gem 'ckan',                            # Read data from CKAN store
  github: 'MAPC/ckan_api',
  branch: 'develop'

# Views
gem 'haml-rails',              '0.5.3' # HAML views
gem 'kaminari',               '0.16.1' # Pagination

# Styles
gem 'sass-rails',              '4.0.3' # Use SCSS for stylesheets
gem 'bootstrap-sass',       '~> 3.2.0' # Responsive base styles
gem 'chosen-rails',            '1.1.0' # Chosen, for friendly dropdowns

# Javascript
gem 'jquery-rails',            '3.1.2' # Use jquery as the JavaScript library
gem 'uglifier',             '>= 1.3.0' # Compressor for JavaScript assets
gem 'coffee-rails',         '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
# gem 'remotipart',              '1.2.1' # Help bind Ajax events to forms
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'turbolinks',   '2.4.0' # Following links are faster.


# Files
gem 'paperclip',      '4.2.0' # Handle file attachments
gem 'retina_rails'            # Load high-res images on Retina displays
gem 'aws-sdk',        '1.5.8' # Upload files to Amazon S3
gem 'asset_sync'              # Upload assets to S3
gem 'rubyzip',     '>= 1.0.0' # Zip files for downloading
gem 'zip-zip'

# Admin
gem 'rails_admin'        # Manage resources
gem 'cancan'             # Authorize admin


# Background Jobs
gem 'redis'              # Dependency for Resque
# gem 'resque'             # Process long-running jobs in the background
# gem 'resque_mailer'      # Process email in the background
# gem 'resque-web', require: 'resque_web' # Web interface for Resque


# Utilities
gem 'bcrypt', '~> 3.1.7' # Helps generate password, used in has_secure_password
gem 'naught'             # Helps build null objects
gem 'stamp', '0.6.0'     # Convenient timestamping
gem 'wannabe_bool'       # To convert boolean-ish values to booleans


# Server
gem 'foreman', '0.75.0' # Manage the server and auxiliary processes


group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end


group :development, :test do
  gem 'rspec-rails',  '~> 2.14.0' # Stick to a specific version

  gem 'spring-commands-rspec', '~> 1.0'
  gem 'factory_girl_rails',    '~> 4.0' # Build factories quickly
  gem 'database_cleaner'
  gem 'guard-rspec',            '4.3.1' # Autorun tests and keep Rails loaded
  gem 'capybara',            '~> 2.2.1' # DSL for integration tests
  gem 'launchy'                         # Enable save_and_open_page
  gem 'faker'                           # Generate fake data
  gem 'vcr',                   '~> 2.4' # Record API calls for tests


  gem 'capybara-webkit'
  gem 'childprocess',          '~> 0.5' # Fix a version conflict
  gem 'webmock',            '~> 1.8.4', # Faking requests (supports VCR)
    require: false 
  gem 'minitest'                        # Unclear why we use this
end


group :test do
  gem 'rake'
  gem 'codeclimate-test-reporter', require: nil
end


group :production do
  gem 'unicorn-rails'  # Use Unicorn as the app server
  gem 'rails_12factor' # Serves static assets and logs to stdout
  gem 'airbrake'       # Reports application errors
end