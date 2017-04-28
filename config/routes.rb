Rails.application.routes.draw do

  get 'proposes/new'

  get 'proposes/create'

  get 'proposes/edit'

  get 'proposes/update'

  get 'proposes/destroy'

  get 'proposes/index'

  get 'proposes/show'

 get     'signup' => 'users#new'
 resources :users do
  member do
    get :following, :followers
  end
 end

 root 'sessions#new'
 get     'login'  => 'sessions#new'
 post    'login'  => 'sessions#create'
 delete  'logout' => 'sessions#destroy'
 resources :activations, only: [:edit]
 resources :password_resets, only: [:new, :create, :edit, :update]
 resources :relationships, only: [:create, :destroy]

end
