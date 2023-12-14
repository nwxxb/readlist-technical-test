Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  # user_root_path to: "books#index"
  root to: "static_pages#home"
end
