Rails.application.routes.draw do

  devise_for :users
  root 'shows#index'
  resources :venues

  resources :shows do
  	resources :comments, only: [:new, :create, :destroy, :edit, :update]
    resources :rsvps, only: [:create]
  end
  resources :rsvps, only: :destroy
  resources :users, only: [:show]

  resources :bands do
  	resources :band_posts, only: [:new, :create, :destroy, :edit, :update]
    resources :photos, only: [:new, :create, :destroy]
    resources :follows, only: [:create]
  end
  resources :follows, only: [:destroy]

end
