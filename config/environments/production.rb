require "active_support/core_ext/integer/time"

Rails.application.configure do
  # ✅ Force production mode
  config.cache_classes = true
  config.eager_load = true

  # ✅ Ensure Rails allows all external requests safely (without breaking security)
  config.hosts.clear

  # ✅ Disable full error reports in production
  config.consider_all_requests_local = false

  # ✅ Cache assets for far-future expiry
  config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{1.year.to_i}" }

  # ✅ Store uploaded files (adjust if using S3, etc.)
  config.active_storage.service = :local

  # ✅ Assume the app is behind an SSL-terminating reverse proxy.
  config.assume_ssl = true

  # ✅ Force SSL but allow health checks
  config.force_ssl = true
  config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # ✅ Log to STDOUT with request IDs (works with Railway)
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::Logger.new(STDOUT)
  config.logger.formatter = ::Logger::Formatter.new
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info").to_sym

  # ✅ Prevent health check logs from cluttering
  config.silence_healthcheck_paths = ["/up"]

  # ✅ Enable Cross-Origin Resource Sharing (CORS) for API requests
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # Change this if you want to restrict API access
      resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options]
    end
  end

  # ✅ Suppress deprecation warnings in production
  config.active_support.report_deprecations = false

  # ✅ Use a durable cache store
  config.cache_store = :solid_cache_store

  # ✅ Configure Active Job to use a durable queue
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  # ✅ Set up email URL for production (change domain as needed)
  config.action_mailer.default_url_options = { host: "tasklist-backend-production.up.railway.app" }

  # ✅ SMTP Email settings (uncomment and configure if needed)
  # config.action_mailer.smtp_settings = {
  #   user_name: Rails.application.credentials.dig(:smtp, :user_name),
  #   password: Rails.application.credentials.dig(:smtp, :password),
  #   address: "smtp.example.com",
  #   port: 587,
  #   authentication: :plain
  # }

  # ✅ Enable locale fallbacks (for missing translations)
  config.i18n.fallbacks = true

  # ✅ Prevent schema dumping after migrations in production
  config.active_record.dump_schema_after_migration = false

  # ✅ Optimize ActiveRecord logging (only show IDs)
  config.active_record.attributes_for_inspect = [:id]

  # ✅ Skip DNS rebinding protection for health checks
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
