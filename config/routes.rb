Rails.application.routes.draw do
  resources :exercises

  resources :workouts
  get "/workouts/(:id)/play", to: "workouts#play"

  get "/test", to: "workouts#test"

  root to: 'visitors#index'
  devise_for :users
  resources :users
  get "/users/(:id)/workouts", to: "users#workouts"

  post "/authorize", to: "authorization#authorize"
end
