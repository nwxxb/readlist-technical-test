Rails.application.routes.draw do
  devise_for :users

  resources :books, only: [:index, :new, :create]

  scope '/api', format: :json do
    get '/books', to: 'books#index_json', as: 'books_json'
    get '/books/:id', to: 'books#show_json', as: 'book_json'
  end
  root to: "books#index"
end
