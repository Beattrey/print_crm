Rails.application.routes.draw do
  require 'sidekiq/web'
  scope :monitoring do
    # Sidekiq Basic Auth from routes on production environment
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.credentials.dig(:SIDEKIQ_AUTH_USERNAME))) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.credentials.dig(:SIDEKIQ_AUTH_PASSWORD)))
    end if Rails.env.production?
    mount Sidekiq::Web, at: '/sidekiq'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks' # Ensure this is correctly defined
  }

  root to: 'home#index'

  post Rails.application.credentials.dig(:google_forms_url) => 'webhooks#callback'

  resources :profiles, only: %i[show new update]
  resources :print_makers

  namespace :customers do
    resources :orders do
      member do
        delete :remove_model
        delete :remove_image
      end
    end
  end

  namespace :print_makers do
    resources :orders do
      collection do
        get :archived_orders
        get :available_orders
      end
    end

    resources :order_invitations do
      member do
        get 'reject'
        get 'accept'
      end
    end

    resources :print_maker_orders, only: %i[new create update] do
      member do
        patch :close_order
      end
    end
  end

  namespace :super_admins do
    resources :users, only: %i[index show update] do
      collection do
        post :update_roles
      end
    end
  end

  namespace :print_maker_admins do
    resources :orders, only: %i[index show] do
      member do
        post :approve_order
        post :reject_order
      end
    end
  end
end
