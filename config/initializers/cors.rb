Rails.application.configure do
    # Other production settings...
    
    # ✅ Ensure CORS middleware is applied in production
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' 
        resource '*', 
          headers: :any, 
          methods: [:get, :post, :patch, :put, :delete, :options]
      end
    end
  end
  