Rails.application.routes.draw do
  root to: "areas#index"

  resources :areas do
    resources :agents, only: :index
  end
end
