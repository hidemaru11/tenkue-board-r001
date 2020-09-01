Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'posts#index'
  resources :posts
  resources :posts do
    post 'add' => 'likes#create'
    delete '/add' => 'likes#destroy'
  end

end
