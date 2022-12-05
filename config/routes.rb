Rails.application.routes.draw do
  resources :parties
  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
    root to: "devise/sessions#create"
  end
devise_for :users
end
