require "active_support/core_ext/integer/time"

Rails.application.configure do
  # ✅ Force production mode
  config.eager_load = true

  # ✅ Allow all external hosts
  config.hosts.clear

  # ✅ Fix CORS (Allow API requests)
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*' # Allows requests from anywhere (⚠ Use with caution)
      resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options]
    end
  end

  # ✅ Fix logger issues
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
  config.log_level = :info

  # ✅ Disable full error reports
  config.consider_all_requests_local = false

  # ✅ Cache assets for far-future expiry
  config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{1.year.to_i}" }

  # ✅ Store uploaded files
  config.active_storage.service = :local

  # ✅ Assume SSL (behind reverse proxy)
  config.assume_ssl = true
  config.force_ssl = true
  config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # ✅ Prevent health check logs from cluttering
  config.silence_healthcheck_paths = ["/up"]

  # ✅ Use a durable cache store
  config.cache_store = :solid_cache_store

  # ✅ Configure Active Job queue
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  # ✅ Set email URL
  config.action_mailer.default_url_options = { host: "tasklist-backend-production.up.railway.app" }

  # ✅ Enable locale fallbacks
  config.i18n.fallbacks = true

  # ✅ Prevent schema dumping after migrations
  config.active_record.dump_schema_after_migration = false

  # ✅ Optimize ActiveRecord logging
  config.active_record.attributes_for_inspect = [:id]

  # ✅ Fix Zeitwerk Eager Loading Issues
  config.eager_load = true
end
