Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  resources :alerts
  resources :users do
    resources :teams
  end

  resources :teams do
    resources :users
    resources :alerts
  end
end
