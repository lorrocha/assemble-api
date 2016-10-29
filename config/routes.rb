Rails.application.routes.draw do
  resources :alerts
  resources :users do
    resources :teams
    resources :alerts
  end

  resources :teams do
    resources :users
    resources :alerts
  end
end
