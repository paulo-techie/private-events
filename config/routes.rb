Rails.application.routes.draw do  resources :events

  resources :users, only: %i[new create show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  get 'logout' => 'sessions#destroy'
end
