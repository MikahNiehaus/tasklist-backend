Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://tasklist-frontend.pages.dev'  # ✅ Use your actual frontend domain
      resource '*', 
        headers: :any, 
        methods: [:get, :post, :patch, :put, :delete, :options]
    end
  end
  