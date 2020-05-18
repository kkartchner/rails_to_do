Rails.application.routes.draw do
  root 'to_dos#index'

  resources :to_dos do
    member do
      post 'toggle'
    end
  end

  get 'signup', to: 'users#new'
  resources :users, only: [:index]

  get 'login', to: 'sessions#new'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
