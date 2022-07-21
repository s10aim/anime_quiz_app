source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.3'
# The original asset pipeline for Rails
gem 'sprockets-rails'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use the Puma web server
gem 'puma', '~> 5.0'
# Use Sass to process CSS
gem 'sassc-rails'
# Bundle and transpile JavaScript
gem 'jsbundling-rails'
# Hotwire's SPA-like page accelerator
gem 'turbo-rails'
# Hotwire's modest JavaScript framework
gem 'stimulus-rails'
# Bundle and process CSS
gem 'cssbundling-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Kredis to get higher-level data types in Redis
# gem "kredis"
# Use Active Model has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use Active Storage variants
# gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'
gem 'simple_form'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem 'pre-commit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'factory_bot_rails'
  gem 'rspec'
  gem 'rspec-rails'
end
