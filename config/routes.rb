Rails.application.routes.draw do
  # APIコントローラへのルーティング
  namespace :api do
    namespace :v1 do
      resources :user, only: [:index, :create]
    end
  end

  root to: 'home#index'
  get "/signup", to: "signup#index"
end
