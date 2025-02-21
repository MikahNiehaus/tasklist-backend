Rails.application.routes.draw do
  resources :rooms, only: [:create, :show], param: :room_code do
    resources :todos, only: [:index, :create, :update, :destroy], param: :id do
      patch :complete, on: :member # Mark a todo as complete
    end
  end
end
