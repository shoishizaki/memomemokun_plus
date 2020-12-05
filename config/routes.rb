Rails.application.routes.draw do

  # APIコントローラへのルーティング
  namespace :api do
    namespace :v1 do
      resources :user, only: [:create]
      resources :sessions, only: [:create]

      get "/get_login_user", to: "sessions#get_login_user"
      delete "/logout", to: "sessions#destroy"

      resources :memos, only: [:create, :destroy]

      get "/memos", to: "memos#index"
      patch "/memos", to: "memos#update"

      resources :todos, only: [:create]
    end
  end

  root to: "home#index"
  get "/signup", to: "signup#index"
  get "/login", to: "session#new"
  get "/memo", to: "memo#index"
  get "/todo", to: "todo#index"
end
