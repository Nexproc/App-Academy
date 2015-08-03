AjaxTwitter::Application.routes.draw do
  resource :feed, only: [:show]
  resource :session, only: [:create, :destroy, :new]
  resources :tweets, only: [:create]
  resources :users, only: [:create, :new, :show] do
    get "search", on: :collection

    resource :follow, only: [:create, :destroy]
  end

  # namespace "flargenstow", defaults: { format: :json } do
  #   # /api/normal_route_name
  # end

  root to: redirect("/feed")
end
