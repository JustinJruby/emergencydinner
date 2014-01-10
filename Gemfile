source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
gem 'friendly_id', '5.0.0.beta4'
gem 'ranked-model'
gem "haml"
#gem 'pry-rails'
gem 'prawn'
# Use sqlite3 as the database for Active Record
group :development, :test do
      gem 'sqlite3'
      gem 'pry'
end
group :production do
      gem 'pg'
  gem 'rails_12factor'
gem 'pry-remote'
end
gem 'rack-canonical-host'

gem "google-api-client"

gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

gem 'acts-as-taggable-on'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

gem 'jquery-ui-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'devise', '3.0.0'
gem 'lockup','>=1.1.6' ,:git => 'https://github.com/JustinJruby/lockup.git'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]