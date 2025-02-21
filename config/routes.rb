Rails.application.routes.draw do
  resources :rooms, only: [:create, :show], param: :room_code do
    resources :todos, only: [:index, :create, :update, :destroy], param: :id do
      patch :toggle, on: :member
    end
  end
end
