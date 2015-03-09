source 'https://rubygems.org'
ruby '2.1.5'

gem 'rails',                '4.1.5'


# Database
gem 'pg',                   '0.17.1'   # Use PostgreSQL as the database for Active Record
gem 'postgres_ext-postgis'             # PostGIS Column Support
gem 'textacular',           '3.2.0'    # Enables PostgreSQL Fulltext Search
gem 'has_scope',            '0.5.1'    # Handle multiply-scoped models
gem 'lazy_columns',
  github: 'jorgemanrubia/lazy_columns' # Lazy-load large columns


# Views
gem 'kaminari',             '0.16.1'   # Pagination
gem 'haml-rails',           '0.5.3'    # HAML views
gem 'chosen-rails',         '1.1.0'    # Use Chosen for friendly dropdowns
gem 'nokogiri',             '>= 1.4.4' # Parsing XML


# Styles
gem 'bootstrap-sass',       '~> 3.2.0' # Responsive base styles
gem 'sass-rails',           '4.0.3'    # Use SCSS for stylesheets
# gem 'compass-rails'


# Javascript
gem 'jquery-rails',         '3.1.2'    # Use jquery as the JavaScript library
gem 'uglifier',             '>= 1.3.0' # Compressor for JavaScript assets
gem 'coffee-rails',         '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Disabled because this might be messing up JavaScript loads,
# at least as the JS is written now.
gem 'turbolinks',   '2.4.0' # Following links are faster.


# Files
gem 'paperclip',   '4.2.0' # Handle file attachments
gem 'retina_rails'
gem 'aws-sdk',     '1.33.0' # Upload files to Amazon S3
gem 'asset_sync'            # Upload assets to S3
gem 'rubyzip',     '>= 1.0.0', require: 'zip' # Zip files for downloading


# Admin
gem 'rails_admin'    # Manage resources
gem 'cancan'         # Authorize admin


# Utilities
gem 'redis'          # Dependency for Resque
gem 'resque'         # Process long-running jobs in the background
gem 'resque_mailer'  # Process email in the background
gem 'stamp', '0.6.0' # Convenient timestamping
gem 'wannabe_bool'   # To convert ENV strings to booleans
gem 'bcrypt', '~> 3.1.7' # Use to generate password. Also used in has_secure_password
gem 'naught'         # In case we can introduce the NullObject pattern somewhere


# Server
gem 'foreman', '0.75.0' # Manage the server and auxiliary processes


group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
end


group :development, :test do
  gem 'rspec-rails',        '~> 2.14.0.rc1'
  gem 'database_cleaner'

  gem 'factory_girl_rails', '~> 4.0'
  gem 'launchy'
  
  gem 'zeus'
  gem 'childprocess',       '0.3.6'
  gem 'capybara',           '~> 2.2.1'
  gem 'poltergeist'

  gem 'minitest'
end


group :test do
  gem 'rake'
  gem 'codeclimate-test-reporter', require: nil
end


group :production do
  gem 'unicorn-rails'     # Use Unicorn as the app server
  gem 'rails_12factor'
  gem 'airbrake'
end