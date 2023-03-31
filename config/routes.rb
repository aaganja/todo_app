Rails.application.routes.draw do
  get 'admin', to: 'admin#index'
  get 'admin/project/:id/tasks', to: 'admin#task'
  resources :projects do
    resources :tasks, :only => [:index, :create, :update, :new]
    post 'tasks/complete', to: 'tasks#complete'
    get 'task_completed', to: 'tasks#completed'
    post 'bulk_task', to: 'tasks#bulk_task'
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#index"
end
