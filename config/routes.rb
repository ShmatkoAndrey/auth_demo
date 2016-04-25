Rails.application.routes.draw do
  resource :users, only: [:new, :create, :show, :index]
  resource :sessions
  root 'users#index'
  post 'sessions/social_auth' => 'sessions#social_auth'
end
