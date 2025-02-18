require_relative "boot"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TasklistBackend
  class Application < Rails::Application
    # Initialize configuration defaults for the originally generated Rails version.
    config.load_defaults 8.0
    config.secret_key_base = ENV['SECRET_KEY_BASE']

    # Ignore `lib/assets`, `lib/tasks`, or anything that doesn't contain `.rb` files
    config.autoload_lib(ignore: %w[assets tasks])

    # ✅ Ensure eager loading is always enabled (Fix duplicate setting)
    config.eager_load = true

    # ✅ Ensure `lib/` is included in eager loading (Fix incorrect setting)
    config.eager_load_paths << Rails.root.join("lib")

    # ✅ If this is an API-only app (JSON responses only), keep this
    # Remove this if your app has views (HTML templates).
    config.api_only = true
  end
end
