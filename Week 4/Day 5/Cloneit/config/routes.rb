Rails.application.routes.draw do
  resources :subs
  resource :user
  resource :session, only: [:create, :new]
  get 'session/logout', to: 'sessions#logout', as: 'logout'
end
