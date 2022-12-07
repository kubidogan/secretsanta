Rails.application.routes.draw do
  resources :gifts
  resources :groups

  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end
  # devise_for :users

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
