Mnemonic::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'displays#index'

  get '/events/birthday_generator', to: 'events#birthday_generator', as: 'events_birthday_generator'
  get '/events/dismiss/:id', to: 'events#dismiss', as: 'events_dismiss'

  get '/people/generate_names', to: 'people#generate_names', as: 'people_generate_names'
  resources :people, only: [:edit, :update]
  get '/people/:id', to: 'people#edit'

  resources :taggings, only: [:new, :create]
  match '/taggings/new_submission', to: 'taggings#new_submission', via: :post, as: 'taggings_new_submission'
  get '/taggings/intermediate_new/:verb_id/:tag_id', to: 'taggings#intermediate_new', as: "taggings_intermediate_new"

end