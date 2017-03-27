Rails.application.routes.draw do
  namespace :api do
    resources :trackers, only: [:index, :show]
  end
end
