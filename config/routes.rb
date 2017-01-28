Rails.application.routes.draw do
 
  resources :users do

  	resources :locations

  end

  post '/users/login', to: 'users#login'
  post '/users/sendNotif', to: 'users#sendNotif'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
