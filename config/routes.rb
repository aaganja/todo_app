Rails.application.routes.draw do
  get 'admin', to: 'admin#index'
  resources :projects do
    resources :tasks, :only => [:index, :create, :update, :new]
    post 'tasks/complete', to: 'tasks#complete'
    get 'task_completed', to: 'tasks#completed'
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#index"
end
