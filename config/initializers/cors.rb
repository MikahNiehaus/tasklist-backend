Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3000', 'https://tasklist-frontend.pages.dev'  # ✅ Allow both local and deployed frontend
  
      resource '*',
        headers: :any,
        methods: [:get, :post, :patch, :put, :delete]
    end
  end
  