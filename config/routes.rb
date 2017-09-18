Rails.application.routes.draw do
  resources :graphs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#frontpage"
  get "/graphs" => "graphs#index"
end
