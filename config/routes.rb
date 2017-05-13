Rails.application.routes.draw do

  get 'likes/create'

  get 'likes/destroy'

 get     'signup' => 'users#new'
 resources :users do
  member do
    get :following, :followers
  end
 end

 root    'proposes#index'
 get     'login'  => 'sessions#new'
 post    'login'  => 'sessions#create'
 delete  'logout' => 'sessions#destroy'
 resources :activations, only: [:edit]
 resources :password_resets, only: [:new, :create, :edit, :update]
 resources :relationships, only: [:create, :destroy]

 resources :proposes do
   resources :likes, only: [:create, :destroy]
 	 collection do
      get 'search'
   end
 end

 resources :request_matches, only: [:create, :destroy]

end
