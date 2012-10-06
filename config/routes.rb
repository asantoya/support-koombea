SupportKoombea::Application.routes.draw do

  get "documents/create"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }, :skip => [:registrations]                                          
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    put 'users' => 'devise/registrations#update', :as => 'user_registration'            
  end

  authenticated :user do
    root :to => "tickets#index"
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end
  resources :tickets do
    resources :comments do
      get "mark_read_comments", :on => :collection
    end
  end

end
