SupportKoombea::Application.routes.draw do

  get "comments/create"

  get "comments/destroy"

  devise_for :users

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
