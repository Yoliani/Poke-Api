Rails.application.routes.draw do
  namespace :api do
    namespace :pokemon do
      root 'pokemon#index'
      get ':id', to: 'pokemon#show_one'
    end
    # root 'pokemon#index'
    # get 'pokemon/:id', to: 'pokemon#show_one'
  end
  # root "pokemon#index"
  # get "/pokemon/:id", to: "pokemon#show_one"
  # get "/pokemon/all", to: "pokemon#show_all"
  # get 'pokemon/querys'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
