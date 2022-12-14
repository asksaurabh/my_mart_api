Rails.application.routes.draw do
  # API definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :tokens, only: [:create]
      resources :products, only: %i[show index create update destroy]
      resources :orders, only: %i[index show create]
    end
  end
end
