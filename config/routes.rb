Rails.application.routes.draw do
  # APIコントローラへのルーティング
  namespace :api do
    namespace :v1 do
      resources :user, only: [:index, :create]
    end
  end

  root to: 'home#index'
  get 'signup/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
