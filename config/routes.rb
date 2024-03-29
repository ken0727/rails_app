Rails.application.routes.draw do

root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get '/bookmarks', to: 'bookmarks#index',  as: 'bookmarks_boards'

  resources :boards, only: %i[new index create edit]
  resources :users, only: %i[new create]

  resources :boards do
  resources :comments
  resources :bookmarks, only: %i[create destroy]
    get "load_comments", on: :member
  end
  
end
