SupportKoombea::Application.routes.draw do

  get "documents/create"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "comments/create"

  get "comments/destroy"

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }

  authenticated :user do
    root :to => "tickets#index"
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end
  resources :tickets do
    resources :comments
  end

end
