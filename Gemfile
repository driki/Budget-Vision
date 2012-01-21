source 'http://rubygems.org'
source 'http://gemcutter.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'slim'
gem 'money'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'geocoder'
gem 'geoip'
gem 'rest-client'
gem 'cancan'
gem 'ancestry'
gem 'paper_trail'
gem 'newrelic_rpm'
gem 'acts-as-taggable-on', '~> 2.2.2'
gem 'tabulous'
gem 'ffaker'
gem 'flickraw'
gem 'best_in_place'
gem 'activerecord-import'
gem 'differ'
gem 'sqlite3'
gem 'refraction'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem 'rspec-rails'
  gem 'webrat'
 	gem 'guard'
 	gem 'spork', '> 0.9.0.rc'
 	gem 'growl'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-spork'
end

group :production do
  gem 'pg'
end