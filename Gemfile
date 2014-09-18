source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Use PostgreSQL as the database for Active Record
gem 'pg'
# Enables PostgreSQL Fulltext Search
gem 'textacular'
# Use has_scope to handle multiply-scoped models
gem 'has_scope'
# Lazily load large columns
gem 'lazy_columns', github: 'jorgemanrubia/lazy_columns'
# Use Kaminari for pagination
gem 'kaminari'
# Use HAML for views
gem 'haml-rails'
# Use Chosen for friendly dropdowns
gem 'chosen-rails'
gem 'compass-rails', github: 'Compass/compass-rails' # Use pre-release for Rails 4 compatibility
# Bootstrap for responsive base styles
gem 'bootstrap-sass', '~> 3.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Convenient timestamping
gem 'stamp'


# Use Watir to crawl the DataCommon for images
gem 'watir'

# Use Foreman to manage the server and multiple processes
gem 'foreman'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

group :development, :test do
  gem 'rspec-rails', '2.13.1'
  gem 'guard-rspec', '2.5.0'
  gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'minitest'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn-rails'

# Use Capistrano for deployment
group :development do
  gem 'capistrano',         '~> 2.0'
  gem 'net-ssh',            '2.7.0'
  gem 'net-ssh-gateway',    '1.2.0'
  gem 'capistrano-unicorn', '0.2.0', :require => false
end

# Use debugger
# gem 'debugger', group: [:development, :test]

