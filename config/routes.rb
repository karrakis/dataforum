Rails.application.routes.draw do
  devise_for :users
  resources :graphs do 
    resources :forum_posts
  end

  resources :users do
    resources :graphs
    resources :forum_posts
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#frontpage"
  get "/graphs" => "graphs#index"
  get "/instructions" => "instructions#index"

  namespace :embed do
     resources :graphs, only: :show, path: "" # -> domain.com/embed/1
  end

  namespace :api do
    namespace :v1 do
      namespace :graphs do
        resources :graphs, path: ""
      end
    end
  end

  post 'authenticate', to: 'authentication#authenticate'

end
