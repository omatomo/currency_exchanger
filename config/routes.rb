Rails.application.routes.draw do

 get     'signup' => 'users#new'
 resources :users
 root 'sessions#new'
 get     'login'  => 'sessions#new'
 post    'login'  => 'sessions#create'
 delete  'logout' => 'sessions#destroy'

end
