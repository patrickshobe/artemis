Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :episodes, only: [:index]
  resources :encodes, only: [:index]
  resources :series, only: [:index, :show]
  get '/episodes/:id/encode', to: 'episodes#encode'

  namespace :api do
    namespace :v1 do
      resources :episodes, only: [:index]
      resources :encodes, only: [:update]
      resources :encode_records, only: [:update, :create, :show]
    end

  end
end
