source 'https://rubygems.org'

ruby '3.3.1'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'tzinfo-data', platforms: %i[ windows jruby ]
gem 'bootsnap', require: false
gem 'pry-rails', '~> 0.3'

gem 'redis', '~> 5.2'
gem 'sidekiq', '~> 7.2', '>= 7.2.4'
gem 'sidekiq-scheduler', '~> 5.0', '>= 5.0.3'

gem 'guard'
gem 'guard-livereload', require: false

gem 'active_model_serializers', '~> 0.10.0'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'ffaker'
end

group :development do
end

group :test do
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'shoulda-matchers', '~> 5.3'
end
