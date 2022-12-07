Rails.application.routes.draw do
  root to: 'welcome#home'
  resources :gifts
  resources :groups
  get '/groups/:id/add_user', to: 'groups#add_user', as: 'add_user'
  post '/groups/:id/add_user', to: 'groups#create_user'
  post '/groups/:id/draw', to: 'groups#make_draw', as: 'draw'

  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end
  # devise_for :users

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  get '/show', to: 'users#show'
end
