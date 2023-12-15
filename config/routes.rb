Rails.application.routes.draw do
  devise_for :users

  resources :books, only: [:index, :new, :create]

  scope '/api', format: :json do
    get '/books', to: 'books#index_json'
    get '/books/:id', to: 'books#show_json'
  end
  root to: "books#index"
  # Defines the root path route ("/")
  # user_root_path to: "books#index"
  # root to: "static_pages#home"
end
