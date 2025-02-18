require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # ✅ Enforce production mode
  config.cache_classes = true
  config.eager_load = true

  # ✅ Ensure the app allows external requests (allows all hosts)
  config.hosts = nil

  # ✅ Full error reports should be disabled in production
  config.consider_all_requests_local = false

  # ✅ Cache assets for far-future expiry since they are all digest-stamped.
  config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{1.year.to_i}" }

  # ✅ Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # ✅ Store uploaded files using the local file system (update if using S3, etc.)
  config.active_storage.service = :local

  # ✅ Assume all access to the app is happening through an SSL-terminating reverse proxy.
  config.assume_ssl = true

  # ✅ Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # ✅ Skip HTTP-to-HTTPS redirect for internal health check endpoints
  config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # ✅ Log to STDOUT with the current request ID as a default log tag.
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::Logger.new(STDOUT)
  config.logger.formatter = ::Logger::Formatter.new
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info").to_sym

  # ✅ Prevent health checks from clogging up logs
  config.silence_healthcheck_paths = ["/up"]

  # ✅ Ensure CORS is properly configured (allows all origins)
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # Be cautious in production, restrict this if needed
      resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options]
    end
  end

  # ✅ Don't log any deprecations.
  config.active_support.report_deprecations = false

  # ✅ Replace the default in-process memory cache store with a durable alternative.
  config.cache_store = :solid_cache_store

  # ✅ Use a durable queuing backend for Active Job.
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  # ✅ Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # ✅ Set host to be used by links generated in mailer templates.
  config.action_mailer.default_url_options = { host: "tasklist-backend-production.up.railway.app" }

  # ✅ SMTP email configuration (update with actual SMTP credentials)
  # config.action_mailer.smtp_settings = {
  #   user_name: Rails.application.credentials.dig(:smtp, :user_name),
  #   password: Rails.application.credentials.dig(:smtp, :password),
  #   address: "smtp.example.com",
  #   port: 587,
  #   authentication: :plain
  # }

  # ✅ Enable locale fallbacks for I18n (default locale used when translation is missing)
  config.i18n.fallbacks = true

  # ✅ Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # ✅ Only use :id for inspections in production.
  config.active_record.attributes_for_inspect = [:id]

  # ✅ Enable DNS rebinding protection and prevent `Host` header attacks.
  # To allow specific hosts, replace `nil` above with:
  # config.hosts = [
  #   "tasklist-backend-production.up.railway.app",   # Allow Railway domain
  #   /.*\.mydomain\.com/  # Allow subdomains of your custom domain
  # ]

  # ✅ Skip DNS rebinding protection for the default health check endpoint.
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
