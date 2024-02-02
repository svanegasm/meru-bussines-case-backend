Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'api/v1/sessions'
  }
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post '/auth/login', to: 'sessions#create'
        delete '/auth/logout', to: 'sessions#destroy'
      end

      resources :clients, except: [:new, :edit]
      resources :products, except: [:new, :edit]
      
      resources :orders, except: [:new, :edit] do
        resources :order_products, only: [:create, :update, :destroy]
      end
    end
  end
end
