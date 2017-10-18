Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/books', to: 'books#index', as: 'books'
  # get '/books/new', to: 'books#new', as: 'new_book'
  # post '/books', to: 'books#create'
  #
  # get '/books/:id', to: 'books#show', as: 'book'
  # get '/books/:id/edit', to: 'books#edit', as: 'edit_book'
  # patch '/books/:id', to: 'books#update'
  # delete '/books/:id', to: 'books#destroy'

  # get '/', to: 'main#index', as: 'root'
  root 'main#index'

  resources :books
  post '/books/:id/mark_read', to: 'books#mark_read', as: 'mark_read'


  resources :authors, only: [:index, :new, :create] do
    resources :books, only: [:index, :new]
  end

  get '/auth/:provider/callback', to: 'users#login', as: 'auth_callback'
  get '/logout', to: 'users#logout', as: 'logout'


  # Build the same nested routes manually
  # get '/authors/:author_id/books', to: 'books#index', as: 'author_books'
  # get '/authors/:author_id/books/new', to: 'books#new', as: 'new_author_book'

  # Don't need post because the author id is part of the form
  # post '/authors/:author_id/books', to: 'books#create'




end
