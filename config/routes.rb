Mnemonic::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'displays#index'

  get '/events/dismiss/:id', to: 'events#dismiss', as: 'events_dismiss'

  resources :people, only: [:edit, :update]
  get '/people/:id', to: 'people#edit'
  get '/people/generate_names', to: 'people#generate_names', as: 'people_generate_names'

  resources :taggings, only: [:new]
  get '/taggings/live_search', to: 'taggings#live_search'

end