Rails.application.routes.draw do
  root to: "areas#index"
  resources :areas
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
