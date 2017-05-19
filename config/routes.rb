Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }, defaults: { format: :json }
  get 'users/me' => 'users#me', as: 'current_user'

  resources :users, except: :create do
    resources :teams, only: :index
  end

  resources :teams do
    resources :users, except: :create
    resources :alerts, shallow: true
  end
end
