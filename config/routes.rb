Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :films do
    member do
      post :join
      post :quit
    end

    resources :reviews
  end

  namespace :account do
    resources :films
    resources :reviews
  end

  root 'films#index'

end
