Rails.application.routes.draw do
  # Defines the routes for the application
  get "/login" => "users#login"
  post "/login" => "users#authenticate"
  get "/logout" => "users#logout"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/feeds/:npub", to: "feed#feed"
  get "/notes/:note_id", to: "notes#note"
  get "/profile/:npub", to: "profiles#profile"
  get "/public", to: "feed#public", as: :public
  # Defines the root path route ("/")
  root "home#index"
end
