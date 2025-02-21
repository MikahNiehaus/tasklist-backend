ENV['RAILS_ENV'] ||= 'test'

require "rails"
require "rails/test_help"

# ✅ Prevent ActiveRecord from loading
if defined?(ActiveRecord)
  ActiveRecord::Base.establish_connection(adapter: "nulldb") rescue nil
end

require "mocha/minitest"
