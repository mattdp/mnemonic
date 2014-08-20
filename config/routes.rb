Mnemonic::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'displays#index'

  get '/events/dismiss/:id', to: 'events#dismiss', as: 'events_dismiss'

  resources :people, only: [:edit, :update]

end