source "https://rubygems.org"


source 'https://rubygems.org'

gem 'pg', '~> 1.2'
gem 'dotenv-rails', groups: [:development, :test]
#gem "tzinfo-data", platforms: %i[ jruby ]
gem 'tzinfo-data'

#for tests
  gem 'rspec-rails'         # RSpec for testing
  gem 'factory_bot_rails'   # FactoryBot for test data
  gem 'faker'               # Faker for random test data
  gem 'database_cleaner'    # Ensures clean test database state


# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.1"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors', require: 'rack/cors'

gem 'active_model_serializers'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  #gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "debug", platforms: %i[ mri ] # Only for MRI Ruby

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  #gem "rubocop-rails-omakase", require: false
end



gem "database_cleaner-active_record", "~> 2.2"

gem "mocha", "~> 2.7"
