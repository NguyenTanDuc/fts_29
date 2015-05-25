Rails.application.routes.draw do
  root 'static_pages#index'

  resources :categories, only: :index

  namespace :admin do
    root "categories#index"
    resources :categories, except: :show
  end
end
