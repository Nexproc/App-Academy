Rails.application.routes.draw do
  post 'session', to: 'sessions#create'
  get 'new_sessions', to: 'sessions#new'
  post 'session/logout', to: 'sessions#logout', as: 'logout_session'
  post 'users', to: 'users#create'
  get 'new_user', to: 'users#new'
  get 'user', to: 'users#show'

  resources :bands

  get '/band/:band_id/albums/new', to: 'albums#new', as: 'new_band_album'
  resources :albums

  get '/albums/:abum_id/tracks/new', to: 'tracks#new', as: 'new_album_track'
  resources :tracks
end
