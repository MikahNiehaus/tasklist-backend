Rails.application.configure do
    # Other production settings...
    
    # ✅ Ensure CORS middleware is applied in production
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'https://tasklist-frontend.pages.dev', 
                'http://localhost:3000', 
                'http://127.0.0.1:3000'  # ✅ Allow both localhost and 127.0.0.1
    
        resource '*',
          headers: :any,
          methods: [:get, :post, :patch, :put, :delete, :options],
          credentials: true  # ✅ Allow cookies & authentication (if needed)
      end
    end
  end
  