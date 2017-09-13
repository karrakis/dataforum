Rails.application.routes.draw do
  resources :graphs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#frontpage_backup"
  get "/new" => "test#new"
  get "/forum" => "test#graph_forum"
  get "/graphs" => "graphs#index"
end
