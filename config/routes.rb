require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products
  resource :cart, only: %i[show create update delete] do
    collection do
      post 'add_item', to: 'carts#add_item'
      delete ':product_id', to: 'carts#delete'
    end
  end

  root "rails/health#show"
end
