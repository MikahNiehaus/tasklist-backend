Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # Allow requests from anywhere (or specify your frontend URL)
      resource '*', 
        headers: :any, 
        methods: [:get, :post, :patch, :put, :delete, :options]
    end
  end
  