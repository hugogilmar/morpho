Morpho::Engine.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy'

  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'
  get 'account', to: 'users#edit'
  put 'account', to: 'users#update'

  get 'new_activation', to: 'activations#new'
  post 'send_activation', to: 'activations#create'
  get 'activate/:token', to: 'activations#show', as: :activate

  get 'new_reset_password', to: 'passwords#new'
  post 'send_reset_password', to: 'passwords#create'
  get 'new_password/:token', to: 'passwords#edit', as: :new_password
  put 'change_password/:token', to: 'passwords#update', as: :change_password

  get 'new_unlock', to: 'unlocks#new'
  post 'send_unlock', to: 'unlocks#create'
  get 'unlock/:token', to: 'unlocks#show', as: :unlock

  root to: 'home#index'
end
