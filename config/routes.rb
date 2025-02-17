Rails.application.routes.draw do
  resources :todos do
    collection do
      get 'pending'
      get 'completed'
      get 'all'
    end
    member do
      patch 'complete'  # ✅ Add this to enable /todos/:id/complete
    end
  end

  root 'todos#index'
end
