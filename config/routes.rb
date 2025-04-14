Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "home#index"
  get "home", to: "home#index", as: "home"

  get "unimplemented", to: "static_pages#unimplemented"

  resources :announcements, only: [ :show ]

  resources :fanclubs, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
    resources :subscriptions, only: [ :create, :destroy ]
    member do
      get :subscribers
    end
  end
  resources :subscriptions, only: [ :index ]

  resources :contents, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  get "my_contents", to: "contents#my_contents", as: :my_contents

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
