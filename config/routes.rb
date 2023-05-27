Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'static_pages#top'
# config/routes.rb
get '/users/new', to: 'users#new', as: 'new_user'
get '/login', to: 'sessions#new', as: 'login'
delete '/logout', to: 'sessions#destroy', as: 'logout'
resources :users

end
