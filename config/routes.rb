Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :labels
  namespace :admin do
    resources :users
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :destroy, :edit, :update]
  get '*path', to: 'application#render404'
  get '*path', to: 'application#render500'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
