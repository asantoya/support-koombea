SupportKoombea::Application.routes.draw do

  get "comments/create"

  get "comments/destroy"

  devise_for :users

  root :to => "tickets#index"					
					
  resources :tickets do
    resources :comments
  end

end
