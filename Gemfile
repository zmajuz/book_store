source 'https://rubygems.org'

gem 'rails', '~> 8.0.2'

gem 'bootsnap', require: false
gem 'kamal', require: false
gem 'pg', '>= 1.5.4'
gem 'puma', '>= 5.0'
gem 'thruster', require: false
gem 'tzinfo-data', platforms: %i[ windows jruby ]

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[ mri windows ], require: 'debug/prelude'
  gem 'factory_bot_rails', '~> 6.5'
  gem 'pry-byebug', '~> 3.11'
  gem 'rspec-rails', '~> 8.0', '>= 8.0.1'
  gem 'rubocop-rails-omakase', require: false
end

group :test do
  gem 'shoulda-matchers', '~> 6.5'
  gem 'simplecov', '~> 0.22.0', require: false
end
