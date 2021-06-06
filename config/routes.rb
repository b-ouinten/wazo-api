Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:show]
    resources :comments, only: [:update, :destroy]
    resources :posts do
      resources :comments, only: [:create, :index, :show]
    end
  end

  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'api/login',
      sign_out: 'api/logout',
      registration: 'api/signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }
end
