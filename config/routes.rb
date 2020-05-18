Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'

  resources :to_dos do
    member do
      post 'toggle'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
