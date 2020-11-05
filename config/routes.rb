Rails.application.routes.draw do

  # APIコントローラへのルーティング
  namespace :api do
    namespace :v1 do
      resources :user, only: [:index, :create]
      resources :sessions, only: [:create]

      get "/get_login_user", to: "sessions#get_login_user"
    end
  end

  root to: 'home#index'
  get "/signup", to: "signup#index"
  get '/session', to: "session#new"
end
