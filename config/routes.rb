require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json },
            path: '/' do # namespace as the folder in app/controllers/api # check available MIME types by typing `$ Mime::SET.collect(&:to_s)
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :update, :destroy] do
        resources :products, only: [:create,:update, :destroy]
      end
      resources :sessions, only: [:create, :destroy]
      resources :products, only: [:show, :index]
    end
  end
end
