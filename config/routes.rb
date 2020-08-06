Rails.application.routes.draw do  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: %i[new create show]
  # resources :events, only: %i[new create show]
  
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  get 'logout' => 'sessions#destroy'

  get 'events/:id/attend' => 'events#attend'
end
