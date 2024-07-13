Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  namespace :api, defaults: { format: :json } do
    resource :account, only: %i[create]
    resources :users, only: %i[show] do
      collection do
        get :me
      end
    end
    resource :session, only: %i[create destroy]
    resources :dishes, only: %i[index create show update destroy]

    namespace :me do
      resource :account, only: %i[update]
    end
  end
end
