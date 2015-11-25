Mnemonic::Application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount_griddler

  resources :communications, only: [:new, :create]

  get '/deeds/precommit', to: 'deeds#precommit', as: 'deeds_precommit'
  resources :deeds, only: [:create, :show, :index]
  get '/deeds/doing/:deed_id/:plan_id', to: "deeds#doing", as: 'deeds_doing'

  root 'displays#index'

  resources :events, only: [:new, :create, :edit, :update]
  get '/events/birthday_generator', to: 'events#birthday_generator', as: 'events_birthday_generator'
  get '/events/dismiss/:id/:dismissed_reason', to: 'events#dismiss', as: 'events_dismiss'
  get '/events/snooze/:id/:snooze_days', to: 'events#snooze', as: 'events_snooze'

  get '/people/table', to: 'people#table', as: "people_table"
  get '/people/generate_names', to: 'people#generate_names', as: 'people_generate_names'
  resources :people, only: [:edit, :update]
  get '/people/:id', to: 'people#edit'

  resources :plans, only: [:index, :show]
  get '/plans/deed/:deed_id', to: 'plans#index', as: "plans_with_deed"
  get '/plans/wip', to: 'plans#wip', as: 'wip'

  resources :surveys, only: [:new, :create, :show]

  resources :taggings, only: [:new, :create]
  match '/taggings/new_submission', to: 'taggings#new_submission', via: :post, as: 'taggings_new_submission'
  get '/taggings/intermediate_new/:verb_id/:tag_id', to: 'taggings#intermediate_new', as: "taggings_intermediate_new"

  resources :tags, only: [:index]
  get '/tags/:name_for_link', to: 'tags#show', as: 'tag'

end