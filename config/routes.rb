Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "login" => "devise/sessions#new"
    get "logout" => "devise/sessions#destroy"
    get "sign_up" => "devise/registration#new"
  end

  resources :categories, only: :index
  resources :exams, except: :new

  authenticated :user do
    root to: "exams#index", as: :authenticated_root
  end
  root "static_pages#index"

  namespace :admin do
    root to: "categories#index"
    resources :categories, except: :show
    resources :questions
    resources :users, only: [:index, :update, :destroy]
  end
end
