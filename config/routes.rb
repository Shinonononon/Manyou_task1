Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy,:show]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :destroy, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
