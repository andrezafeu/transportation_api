Rails.application.routes.draw do
  namespace :api do
    resources :trackers, only: [:index, :show]
    get 'real_time_position/:id', to: 'trackers#real_time_position'
  end
end