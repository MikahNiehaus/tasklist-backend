Rails.application.routes.draw do
  resources :rooms, only: [:create, :show, :update, :destroy], param: :room_code
    resources :todos, only: [:index, :create, :update, :destroy], param: :id do
      patch :toggle, on: :member
    end
  end
end
