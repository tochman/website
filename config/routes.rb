Website::Application.routes.draw do
  resources :projects

  devise_for :users
  root :to => 'visitors#new'
  get '/contributors', :to => 'contributors#index'
  get '/404', :to => 'errors#not_found'
  get '/422', :to => 'errors#server_error'
  get '/500', :to => 'errors#server_error'
end
