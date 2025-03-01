Rails.application.routes.draw do
  
  # Authentication routes
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  # Root path
  root 'home#index'
  
  # Profile routes
  resources :profiles, only: [:show, :edit, :update]
  
  # Job routes
  resources :jobs do
    # Nested proposal routes
    resources :proposals, only: [:create, :index]
  end
  
  # Standalone proposal routes
  resources :proposals, only: [:show, :edit, :update, :destroy] do
    # Action to accept a proposal
    member do
      post :accept
    end
  end
  
  # Contract routes with nested resources
  resources :contracts, only: [:index, :show, :new, :create] do
    resources :time_entries, only: [:index, :create]
    resources :payments, only: [:index, :create]
    
    # Contract actions
    member do
      post :complete
      post :cancel
    end
  end
  
  # Dashboard routes
  namespace :dashboard do
    get '/', to: 'home#index'
    get '/client', to: 'client#index'
    get '/freelancer', to: 'freelancer#index'
    get '/admin', to: 'admin#index'
  end
  
  # Search routes
  get '/search/jobs', to: 'search#jobs'
  get '/search/freelancers', to: 'search#freelancers'
  
  # API routes for Alpine.js interactions
  namespace :api do
    resources :jobs, only: [:index, :show]
    resources :proposals, only: [:create]
    resources :time_entries, only: [:create, :update]
    
    # Endpoints for dashboard data
    get 'dashboard/stats', to: 'dashboard#stats'
  end
  
  # Admin routes
  namespace :admin do
    resources :users
    resources :jobs
    resources :contracts
    resources :payments
    
    # Admin dashboard
    get 'dashboard', to: 'dashboard#index'
  end
end
