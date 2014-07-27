Mnemonic::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'displays#index'

end