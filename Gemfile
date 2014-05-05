source 'https://rubygems.org'

ruby '2.1.0'

gem 'rails', '~> 4.1.0'
gem 'unicorn'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'figaro'
gem 'mongoid', github: 'mongoid/mongoid', tag: 'v4.0.0.beta1'
gem 'moped', github: 'mongoid/moped', tag: 'v2.0.0.beta6'
gem 'mongoid_indexing'
gem 'mongoid_search'
gem 'devise'
gem 'mongoid-pagination'


# Location Gems
gem 'factual-api'
gem 'vincenty'
gem 'mongoid_geospatial'

# Attachments
gem 'mongoid-paperclip', require: 'mongoid_paperclip'
gem 'aws-sdk', '~> 1.3.4'

# Support Gems
gem 'newrelic_rpm'

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'vcr'
  gem 'zeus'
end

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard' # Mac OS X 10.8 only
end

group :test do
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'webmock'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
