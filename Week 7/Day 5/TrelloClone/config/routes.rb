Rails.application.routes.draw do
  root to: 'static_pages#index'

  resources :static_pages, only: [:index]
  resources :boards, defaults: { format: :json }, only: [:create, :update, :show, :index, :destroy] do
    resources :lists, only: [:create, :update, :show, :index] do
      resources :cards, only: [:create, :update, :show, :index] do
        resources :todo_items, only: [:create, :update, :show, :index]
      end
    end
  end
  resources :lists, only: [:destroy]
  resources :cards, only: [:destroy]
  resources :todo_items, only: [:destroy]

end
