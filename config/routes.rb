Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'posts/about'
  get 'posts/user_info'
  devise_for :users
  resources :posts do
    resources :comments
    member do
      put "like", to: "posts#like"
      put "unlike", to: "posts#unlike"
    end
  end
  root "posts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
