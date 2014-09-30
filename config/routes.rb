Rails.application.routes.draw do
  resources :exercises

  resources :workouts
  get "/workouts/(:id)/play", to: "workouts#play"

  get "/test", to: "workouts#test"

  root to: 'visitors#index'
  devise_for :users
  resources :users
  get "/users/(:id)/workouts", to: "users#workouts"
  match "/users/(:id)/workouts", to: "cors_preflight#options", via: [:OPTIONS]
  match "/workouts/(:id)", to: "cors_preflight#options", via: [:OPTIONS]

  match "/authorization/(:action)", to: "authorization#(:action)", via: [:OPTIONS]
  post "authorization/authorize"
  get "authorization/revoke"
  get "authorization/check_validity"
end
