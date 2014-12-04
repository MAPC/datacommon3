source 'https://rubygems.org'

gem 'rails',                '4.1.5'

# Database
gem 'pg',                   '0.17.1' # Use PostgreSQL as the database for Active Record
gem 'textacular',           '3.2.0'  # Enables PostgreSQL Fulltext Search
gem 'active_hash',          '1.3.0'  # Mock database tables
gem 'has_scope',            '0.5.1'  # Handle multiply-scoped models
gem 'lazy_columns', github: 'jorgemanrubia/lazy_columns' # Lazy-load large columns

# Views
gem 'kaminari',             '0.16.1'   # Pagination
gem 'haml-rails',           '0.5.3'    # HAML views
gem 'chosen-rails',         '1.1.0'    # Use Chosen for friendly dropdowns
gem 'nokogiri',             '>= 1.4.4' # Parsing XML

# Styles
gem 'bootstrap-sass',       '~> 3.2.0' # Responsive base styles
gem 'sass-rails',           '4.0.3' # Use SCSS for stylesheets
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
gem 'paperclip', '~> 3.0' # Handle file attachments
gem 'retina_rails'
gem 'aws-sdk',   '1.33.0' # Upload files to Amazon S3
gem 'rubyzip', '>= 1.0.0', require: 'zip' # Zip files for downloading


# Server
gem 'foreman', '0.75.0' # Manage the server and auxiliary processes
gem 'unicorn-rails'     # Use Unicorn as the app server


# Utilities
gem 'mail'
gem 'stamp', '0.6.0' # Convenient timestamping
gem 'wannabe_bool'   # To convert ENV strings to booleans


group :development, :test do
  gem 'rspec-rails',        '2.13.1'
  gem 'database_cleaner'

  gem 'factory_girl_rails', '~> 4.0'
  gem 'launchy'

  # gem 'guard-rspec',        '2.5.0'
  gem 'spork-rails',        '4.0.0'
  # gem 'guard-spork',        '1.5.0'
  gem 'childprocess',       '0.3.6'
  # gem 'selenium-webdriver', '2.35.1'
  gem 'capybara',           '2.1.0'

  gem 'minitest'
end


# Use Capistrano for deployment
group :development do
  gem 'capistrano',         '~> 2.0'
  gem 'net-ssh',            '2.7.0'
  gem 'net-ssh-gateway',    '1.2.0'
  gem 'capistrano-unicorn', '0.2.0', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
end


# Use to generate password. Also used in has_secure_password
gem 'bcrypt', '~> 3.1.7'


# Unused, but potential


# Use debugger
# gem 'debugger', group: [:development, :test]

# gem 'jbuilder',             '~> 2.0' # Build JSON APIs with ease.

# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc',                 '~> 0.4.0',          group: :doc
