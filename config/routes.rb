Rails.application.routes.draw do
devise_for :users

  root 'home#top'

  get 'home/about'

  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]

  resources :users, only: [:show, :edit, :update,:index]
end  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlend
