source 'https://rubygems.org'

gem 'rails', '4.1.5'
gem 'haml-rails'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bcrypt-ruby', require: 'bcrypt'

gem 'cancancan'
gem 'activeadmin', github: 'activeadmin'

gem 'kaminari'

# image
gem 'carrierwave'
gem 'rmagick'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'thin', require: false
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'launchy'
end

group :production, :staging do
  gem 'therubyracer'
end

group :development do
  gem 'erb2haml'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry', group: :test
  gem 'pry-rails'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
